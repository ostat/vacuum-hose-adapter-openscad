# Generated png images from STL files, and then creates a montage for each folder.
#
# STL to PNG is done by stl-thumb
# https://github.com/unlimitedbacon/stl-thumb
#
# montage is created by imagemagick
# https://imagemagick.org/script/montage.php
#
# version 2022-10-04

$script:ScriptFolder = (Get-Item $MyInvocation.MyCommand.Source).Directory
$script:ImageMagickPath = 'C:\Program Files\ImageMagick-7.1.0-Q16-HDRI\magick.exe'
$script:StlThumbPath = 'C:\bin\stl-thumb\stl-thumb.exe'

# online colour picker https://colorpicker.me/
$script:HueMin = 0   #min value is 0
$script:HueMax = 220 #max value is 360

$Script:ForceRegeneration = $false

#List of sizes that will be used to pick the hue colour.
$SourceFolders = @(
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\hoseadapter\');
        ConnectorType = 'Hose Adapters'
        SetTitle = 'Hose Adapters\n[SetName] [ParentFolderName]'
        ConnectorTitle = 'Hose Adapters\n[ParentFolderName]'
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
        HueMin = 0   #min value is 0
        HueMax = 220 #max value is 360
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\magneticadapter\');
        ConnectorType = 'Magnetic Connectors'
        SetTitle = 'Magnetic Connectors\n[SetName] [ParentFolderName]'
        ConnectorTitle = 'Magnetic Connectors\n[ParentFolderName]'
        Options = @('0deg'         
             '30deg'     
             '30degsweep'                
             '45deg'   
             '45degsweep'                
             '90deg' 
             '90degsweep');
        HueMin = 0   #min value is 0
        HueMax = 220 #max value is 360
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\flange\');
        ConnectorType = 'Flange'
        SetTitle = 'Flange [SetName]\n25.4mm(1in) to 114mm(4.5in)'
        ConnectorTitle = 'Flange\n25.4mm(1in) to 114mm(4.5in)'
        Options = @('0deg'         
             '30deg'     
             '45deg'   
             '90deg');
        HueMin = 0   #min value is 0
        HueMax = 220 #max value is 360
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\dyson\');
        connectorType = 'Dyson V6' 
        SetTitle = 'Funnel [SetName]'
        ConnectorTitle = 'Dyson V6'
        Options = @();
        HueMin = 0   #min value is 0
        HueMax = 220 #max value is 360
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\funnel\');
        connectorType = 'Funnels'
        SetTitle = 'Funnels [SetName]'
        ConnectorTitle = 'Funnels\n25mm to 200mm'
        Options = @();
        HueMin = 180   #min value is 0
        HueMax = 300 #max value is 360
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\funnel_offcenter\');
        ConnectorType = 'Offset Funnels'
        SetTitle = 'Offset Funnels\n[SetName]'
        ConnectorTitle = 'Offset Funnels\n25mm to 200mm'
        Options = @();
        HueMin = 180   #min value is 0
        HueMax = 300 #max value is 360
    }
)

function CreateFolderIfNeeded([string] $path) {

    if(!(Test-Path -LiteralPath $path))
    {
        New-Item $path -ItemType Directory
    }
}

Function IIf($If, $Right, $Wrong) {if ($If) { return $Right } else { return $Wrong }}

function GenerationNeeded($targetPath, $sourceItem) {
    if(Test-Path $targetPath) {
        $targetItem = Get-Item $targetPath
        if($sourceItem.LastWriteTimeUtc -gt $targetItem.LastWriteTimeUtc) {
            Write-Verbose "Regenerating $targetPath targetItem:$($targetItem.LastWriteTimeUtc) newestFile:$($sourceItem.LastWriteTimeUtc)"
            return $true
        }
        else{
            Write-Verbose "Skip regenerating $targetPath targetItem:$($targetItem.LastWriteTimeUtc) newestFile:$($sourceItem.LastWriteTimeUtc)"
        }
    }
    else {
        Write-Verbose "Target does not exist $targetPath"
        return $true
    }
    return $false
}

function Create-Montage{
    param(
        [string]$Path,
        [string]$TargetFilename,
        [string]$Title,
        [int]$PointRatio,
        $Files
    )

    cd $Path
    #create the montage of the images.
    # montage, trim to remove white space from inages, -geometry256x256+2+2 add small border and keep all images the same size
    & $script:ImageMagickPath montage -geometry 256x256+2+2 -trim $Files $TargetFilename
    Start-Sleep -Seconds 3
    
    #get the image size
    $width = [System.Convert]::ToInt16((& $script:ImageMagickPath identify -format %w $TargetFilename))
    $height = [System.Convert]::ToInt16((& $script:ImageMagickPath identify -format %h $TargetFilename))
    $MaxWidth = 2536
    if($width -gt $MaxWidth){
        $percentage = [math]::Round(($MaxWidth / $width * 100),1)
    }
    else
    {
        $percentage = 100
    }

    $ofset = [math]::Floor(($height)/6) *$percentage/100
    $pointsize = [math]::Floor(($width)/$PointRatio)
    Write-Verbose "height:$height, width:$width, percentage:$percentage ofset:$ofset pointsize:$pointsize"
    & $script:ImageMagickPath convert -resize "$($percentage)%" -background '#000b' -geometry "+0+$($ofset)" -fill white -gravity center -pointsize $pointsize -size $width caption:"$($Title)" $TargetFilename +swap -gravity south -composite $TargetFilename    
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
    $SourceSettings = $_
    $sourceFolder =  $SourceSettings.Path
    $Options =  $SourceSettings.Options
    $sourceFolderItem = Get-Item $sourceFolder

    $connectorType = $SourceSettings.ConnectorType

    # Create a PNG from the STL
    Get-ChildItem -LiteralPath $SourceFolder -Recurse -Filter '*.stl' | ForEach-Object {
        $stl = $_
        $setName = $stl.Directory.Name
        $targetFolder = "$($stl.Directory.Parent.FullName)\thumb\$($setName)"

        CreateFolderIfNeeded $targetFolder
    
        $targetPath= Join-Path $targetFolder "$($stl.BaseName).png"
        $generateThumb = GenerationNeeded $targetPath $stl.

        if($generateThumb -or $Script:ForceRegeneration) {
            if($options.count -eq 0){
                $folderOptions = (Get-ChildItem -LiteralPath $stl.Directory.Parent.FullName -Directory ) | Where-Object {$_.Name -ne 'thumb'} | Select-Object -ExpandProperty Name | Sort-Object {[decimal]($_ -replace '.*?(\d*\.?\d*?).*', '$1')}
            }
            else{
                $folderOptions = $options     
            }

            # Pick hue based on the size and position in the array, I want each size to be a different colour.
            $hue = $SourceSettings.HueMax - [Math]::Floor([array]::indexof($folderOptions,$setName) * ($SourceSettings.HueMax - $SourceSettings.HueMin) / ($folderOptions.Length - 1))

            $colour = ConvertFrom-Hsl $hue 50 60 -ABGR
            $colour2 = ConvertFrom-Hsl $hue 50 20 -ABGR

            write-host "$($stl.FullName) $colour2 $colour"
            & $script:StlThumbPath --material $colour2 $colour 111111 $($stl.FullName) $targetPath
        }
    }

    # Create thunbnail sets
    Get-ChildItem -LiteralPath $SourceFolder -Recurse -Filter 'thumb' -Directory | ForEach-Object { 
        $thumbFolder = $_

        # Thunbnails for sub folders.
        Get-ChildItem -LiteralPath $thumbFolder.FullName -Directory  | ForEach-Object {
            $folder = $_

            $setName = $folder.Name
            $title = $SourceSettings.SetTitle.Replace('[SetName]', $setName).Replace('[ParentFolderName]',$thumbFolder.Parent.Name);
            Write-Host "$($folder.FullName) | $title"
      
            $targetFileName = "$($setName)_display.jpg"
            $newestFile = Get-ChildItem -LiteralPath $folder.FullName | Sort-Object LastAccessTime -Descending | Select-Object -First 1
            $generateThumb = GenerationNeeded (Join-Path $thumbFolder.FullName $targetFileName) $newestFile

            if($generateThumb -or $Script:ForceRegeneration) {
                # montage, trim to remove white space from inages, -geometry +2+2 add small border
                #& $script:ImageMagickPath montage -adjoin -geometry +2+2 -trim -title "$($title)" 
                Create-Montage -Path $thumbFolder.FullName `
                    -TargetFilename $targetFileName `
                    -PointRatio 17 `
                    -Title $title `
                    -Files "$($setName)\*.png"  
            }
            else{
                Write-Verbose "Skipping file set $($title)"
            }
        }

        $stlCount = (Get-ChildItem $thumbFolder.Parent.FullName -Recurse -Filter *.stl).Length

        $title = $SourceSettings.ConnectorTitle.Replace('[SetName]', $folder.Name).Replace('[ParentFolderName]',$thumbFolder.Parent.Name);
        
        # for each child folder add wild card search, sort them by the number value (so 20 comes before 100)
        $files = Get-ChildItem -LiteralPath $thumbFolder.FullName -Directory | Select-Object @{name='Name';expression={"$($_.Name)\*.png"}} | Select-Object -ExpandProperty Name | Sort-Object {[decimal]($_ -replace '(\d+\.?\d*).*', '$1')}
        $filesString = $files | Join-String -Separator " "

        Write-Host "$($thumbFolder.FullName) | $title"

    
        $targetFileName = "display.jpg"
        $targetPath = (Join-Path $thumbFolder.FullName $targetFileName)
       
        $newestFile = Get-ChildItem $thumbFolder.Parent.FullName -Recurse -Filter *.stl | Sort-Object LastAccessTime -Descending | Select-Object -First 1
        $generateCompleteSet = GenerationNeeded $targetPath $newestFile
        if($generateCompleteSet -or $Script:ForceRegeneration) {
            # montage, trim to remove white space from inages, -geometry256x256+2+2 add small border and keep all images the same size
            #& $script:ImageMagickPath montage -geometry 256x256+2+2 -pointsize 24 -trim -title "$($title)" $files display.webp
            Create-Montage -Path $thumbFolder.FullName `
                -TargetFilename $targetFileName `
                -PointRatio 14 `
                -Title $title `
                -Files $files 

            # thumb for a random selection
            $takeCount = 36
            $files = Get-ChildItem -LiteralPath $thumbFolder.FullName -Recurse -Filter '*.png' | Sort-Object { Get-Random } | select -First $takeCount | Select-Object @{name='Name';expression={"$($_.Directory.Name)\$($_.Name)"}} | Select-Object -ExpandProperty Name
            Write-Host "$($thumbFolder.FullName) | $title | thunbnail summary set $takeCount"
            Create-Montage -Path $thumbFolder.FullName `
                -TargetFilename "display_$takeCount.jpg" `
                -PointRatio 14 `
                -Title $title `
                -Files $files 
        }
        else{
            Write-Verbose "Skipping thunbnail complete set $($title)"
        }
    }
}


$title = 'hose connectors'

# thumb for a random selection
$takeCount = 36
$path = (Join-Path $script:ScriptFolder '\generated')
cd $path
$files = Get-ChildItem -LiteralPath $path -Recurse -Filter '*.png' | Sort-Object { Get-Random } | select -First $takeCount | Select-Object @{name='Name';expression={"$($_.Directory.FullName)\$($_.Name)"}} | Select-Object -ExpandProperty Name
Write-Host "$($thumbFolder.FullName) | $title | thunbnail summary set $takeCount"
Create-Montage -Path $path `
    -TargetFilename "display_$takeCount.jpg" `
    -PointRatio 10 `
    -Title $title `
    -Files $files 

