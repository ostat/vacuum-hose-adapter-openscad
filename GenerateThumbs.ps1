# Generated png images from STL files, and then creates a montage for each folder.
#
# STL to PNG is done by stl-thumb
# https://github.com/unlimitedbacon/stl-thumb
#
# montage is created by imagemagick
# https://imagemagick.org/script/montage.php
#
#version 2022-10-02

$script:SourceFolder = (Get-Item $MyInvocation.MyCommand.Source).Directory
$script:ImageMagickPath = 'C:\Program Files\ImageMagick-7.1.0-Q16-HDRI\magick.exe'
$script:StlThumbPath = 'C:\bin\stl-thumb\stl-thumb.exe'
$SourceFolders = @(
    @{
        Path = (Join-Path $script:SourceFolder '\generated\hoseadapter\');
        Options = @('25.4mm(1in)'         
             '31.75mm(1.25in)'     
             '32mm'                
             '34.925mm(1.375in)'   
             '35mm'                
             '36.5125mm(1.4375in)' 
             '38mm'                 
             '38.1mm(1.5in)'       
             '40mm'                 
             '50mm'                
             '50.8mm(2in)'         
             '60mm'                 
             '63.5mm(2.5in)'        
             '76.2mm(3in)'          
             '88.9mm(3.5in)'        
             '100mm'                
             '101.6mm(4in)'         
             '114.3mm(4.5in)');
    },
    @{
        Path = (Join-Path $script:SourceFolder '\generated\magneticadapter');
        Options = @('0deg'         
             '30deg'     
             '30degsweep'                
             '45deg'   
             '45degsweep'                
             '90deg' 
             '90degsweep');
        }
)


$Script:ForceRegeneration = $false

#List of sizes that will be used to pick the hue colour.


function CreateFolderIfNeeded([string] $path) {

    if(!(Test-Path -LiteralPath $path))
    {
        New-Item $path -ItemType Directory
    }
}

function ConvertFrom-Hsl {
    param(
        $Hue,
        $Saturation,
        $Lightness, 
        # Return in ConEmu.xml ABGR hex format
        [Switch]$ABGR
    )
    
    function ToHex ($c) {
        $hex = [Convert]::ToString([Math]::Round($c * 255), 16).ToUpper()
        if ($hex.Length -eq 1) {
            "0$hex"
        } else {
            "$hex"
        }
    }

    $Hue = [double]($Hue / 360)
    if ($Saturation -gt 1) {
        $Saturation = [double]($Saturation / 100)
    }
    if ($Lightness -gt 1) {
        $Lightness = [double]($Lightness / 100)
    }
    
    if ($Saturation -eq 0) {
        # No color
        $red = $green = $blue = $Lightness
    } else {
        function HueToRgb ($p,$q,$t) {
            if ($t -lt 0) {
                $t++
            }
            if ($t -gt 1) {
                $t--
            } 
            if ($t -lt 1/6) {
                return $p + ($q - $p) * 6 * $t
            } 
            if ($t -lt 1/2) {
                return $q
            }
            if ($t -lt 2/3) {
                return $p + ($q - $p) * (2/3 - $t) * 6
            }
            return $p
        }
        $q = if ($Lightness -lt .5) {
            $Lightness * (1 + $Saturation)
        } else {
            $Lightness + $Saturation - $Lightness * $Saturation
        }
        $p = 2 * $Lightness - $q
        $red = HueToRgb $p $q ($Hue + 1/3)
        $green = HueToRgb $p $q $Hue
        $blue = HueToRgb $p $q ($Hue - 1/3)
    }
    
    if ($ABGR) {
        $b = ToHex $blue
        $g = ToHex $green
        $r = Tohex $red
        "$r$g$b"
    } else {
        [Ordered]@{
            Red = [Math]::Round($red * 255)
            Green = [Math]::Round($green * 255)
            Blue = [Math]::Round($blue * 255)
        }
    }
}

$SourceFolders | ForEach-Object {
    $sourceFolder =  $_.Path
    $Options =  $_.Options
    $sourceFolderItem = Get-Item $sourceFolder

    # Create a PNG from the STL
    Get-ChildItem -LiteralPath $SourceFolder -Recurse -Filter '*.stl' | ForEach-Object {
        $stl = $_

        $angle = $stl.Directory.Parent.FullName
        $size = $stl.Directory.Name
        $targetFolder = "$($angle)\thumb\$($size)"
        CreateFolderIfNeeded $targetFolder
    
        $targetName = Join-Path $targetFolder "$($stl.BaseName).png"
        if(!(Test-Path $targetName) -or $Script:ForceRegeneration)
        {
            # Pick hue based on the size and position in the array, I want each size to be a different colour.
            # Hue 0 and 360 are both red, dont subtract 1 from legth
            $hue = [Math]::Floor([array]::indexof($Options,$size) *360 / $Options.Length)

            $colour = ConvertFrom-Hsl $hue 50 60 -ABGR
            $colour2 = ConvertFrom-Hsl $hue 50 20 -ABGR

            write-host "$($stl.FullName) $colour2 $colour"
            & $script:StlThumbPath --material $colour2 $colour 111111 $($stl.FullName) $targetName
        }
    }

    # Create thunbnail sets
    Get-ChildItem -LiteralPath $SourceFolder -Recurse -Filter 'thumb' -Directory | ForEach-Object { 
        $thumbFolder = $_

        $angle = $thumbFolder.Parent.Name
        $title = "$angle $($sourceFolderItem.Name)"

        # for each child folder add wild card search, sort them by the number value (so 20 comes before 100)
        $files = Get-ChildItem -LiteralPath $thumbFolder.FullName -Directory | Select-Object @{name='Name';expression={"$($_.Name)\*.png"}} | Select-Object -ExpandProperty Name | Sort-Object {[decimal]($_ -replace '(\d+\.?\d*).*', '$1')}
        $filesString = $files | Join-String -Separator " "

        Write-Host "$($thumbFolder.FullName) | $title"

        # montage, trim to remove white space from inages, -geometry256x256+2+2 add small border and keep all images the same size
        cd $thumbFolder.FullName
        & $script:ImageMagickPath montage -geometry 256x256+2+2 -pointsize 24 -trim -title "$($title)" $files display.webp
    
        # Thunbnails for sub folders.
        Get-ChildItem -LiteralPath $thumbFolder.FullName -Directory  | ForEach-Object {
            $folder = $_

            $size = $folder.Name
            $title = "$size $angle $($sourceFolderItem.Name)"

            Write-Host "$($folder.FullName) | $title"

            # montage, trim to remove white space from inages, -geometry +2+2 add small border
            & $script:ImageMagickPath montage -adjoin -geometry +2+2 -trim -title "$($title)" "$($size)\*.png" "$($size)_display.webp"
        }
    }
}