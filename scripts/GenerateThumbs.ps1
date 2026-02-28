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
$script:ImageMagickPath = 'C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe'
$script:StlThumbPath = 'C:\bin\stl-thumb\stl-thumb.exe'

$script:configPath = Join-Path (Get-Item $MyInvocation.MyCommand.Source).Directory 'info.json'

$VerbosePreference = "SilentlyContinue"

# online colour picker https://colorpicker.me/
$script:HueMin = 0  
$script:HueMax = 360

$script:SummarySetCount = 7*5
$script:SummarySetTile = '7x5'

$Script:ForceRegeneration = $false

#List of sizes that will be used to pick the hue colour.
#'[SetName]' = STL's folder name
#[ParentFolderName] = STL's parent folder name
$SourceFolders = @(
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\centec\');
        ConnectorType = 'CenTec Quick Click Compatable'
        SetTitle = 'CenTec [ParentFolderName]\n[SetName]'
        ConnectorTitle = 'CenTec Quick connect\n[ParentFolderName]'
        Connector = 'CenTec Quick connect'
        Options = @();
        HueMin = 60   #min value is 0
        HueMax = 110 #max value is 360
        SaturationMin = 50
        SaturationMax = 50
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\dw735\');
        ConnectorType = 'DW735 attachements'
        SetTitle = 'DW735 [ParentFolderName]\n[SetName]'
        ConnectorTitle = 'DW735\n[ParentFolderName]'
        Connector = 'DW735'
        Options = @();
        HueMin = 60   #min value is 0
        HueMax = 110 #max value is 360
        SaturationMin = 50
        SaturationMax = 50
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\camlock\');
        ConnectorType = 'CAMLOCK attachements'
        SetTitle = 'CAMLOCK [ParentFolderName]\n[SetName]'
        ConnectorTitle = 'CAMLOCK\n[ParentFolderName]'
        Connector = 'CAMLOCK'
        Options = @();
        HueMin = 60   #min value is 0
        HueMax = 110 #max value is 360
        SaturationMin = 50
        SaturationMax = 50
    },
   @{
        Path = (Join-Path $script:ScriptFolder '\generated\magneticadapter\');
        ConnectorType = 'Magnetic Connectors'
        SetTitle = 'Magnetic Quick Connectors\n[SetName] [ParentFolderName]'
        ConnectorTitle = 'Vacuum hose\nMagnetic Quick Connectors'
        Connector = 'Vacuum hose'
        Options = @();
        HueMin = 10   #min value is 0
        HueMax = 40  #max value is 360
        SaturationMin = 50
        SaturationMax = 70
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\hoseadapter\');
        ConnectorType = 'Hose Adapters'
        SetTitle = 'Hose Adapters\n[SetName] [ParentFolderName]'
        ConnectorTitle = 'Hose Adapters\n[ParentFolderName]'
        Connector = 'Hose Adapters'
        Options = @();
        HueMin = 120   #min value is 0
        HueMax = 180 #max value is 360
        SaturationMin = 35
        SaturationMax = 60
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\hosesplitter\');
        ConnectorType = 'Hose Splitter'
        SetTitle = 'Hose Splitter\n[SetName]'
        ConnectorTitle = 'Hose Splitter\n25.4mm(1in) to 114mm(4.5in)'
        Connector = 'Hose Splitter'
        Options = @();
        HueMin = 120   #min value is 0
        HueMax = 180 #max value is 360
        SaturationMin = 65
        SaturationMax = 95
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\barbedhoses\');
        ConnectorType = 'Hose Splitter'
        SetTitle = 'Tube fittings\n[SetName]'
        ConnectorTitle = 'Tube fittings\n4mm to 26mm'
        Connector = 'Tube fittings'
        Options = @();
        HueMin = 180   #min value is 0
        HueMax = 220 #max value is 360
        SaturationMin = 40
        SaturationMax = 40
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\barbedsplitter\');
        ConnectorType = 'Hose Splitter'
        SetTitle = 'Tube fittings\n[SetName]'
        ConnectorTitle = 'Tube fittings\n4mm to 26mm'
        Connector = 'Tube fittings'
        Options = @();
        HueMin = 180   #min value is 0
        HueMax = 220 #max value is 360
        SaturationMin = 50
        SaturationMax = 80
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\pvchoseadapter\');
        ConnectorType = 'Hose to tube Adapters'
        SetTitle = 'Hose to tube Adapters\n[SetName]'
        ConnectorTitle = 'Hose to tube Adapters'
        Options = @();
        HueMin = 160   #min value is 0
        HueMax = 200 #max value is 360
        SaturationMin = 40
        SaturationMax = 40
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\magneticadapter\');
        ConnectorType = 'Magnetic Connectors'
        SetTitle = 'Magnetic Connectors\n[SetName] [ParentFolderName]'
        ConnectorTitle = 'Magnetic Connectors\n[ParentFolderName]'
        Options = @();
        HueMin = 10   #min value is 0
        HueMax = 40  #max value is 360
        SaturationMin = 50
        SaturationMax = 70
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\flange\');
        ConnectorType = 'Flange'
        SetTitle = 'Flange [SetName]\n25.4mm(1in) to 114mm(4.5in)'
        ConnectorTitle = 'Flange\n25.4mm(1in) to 114mm(4.5in)'
        Options = @();
        HueMin = 200   #min value is 0
        HueMax = 220 #max value is 360
        SaturationMin = 80
        SaturationMax = 80
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\dyson\');
        connectorType = 'Dyson V6' 
        SetTitle = 'Dyson V6 [SetName]'
        ConnectorTitle = 'Dyson V6'
        Options = @();
        HueMin = 310   #min value is 0
        HueMax = 355 #max value is 360
        SaturationMin = 60
        SaturationMax = 60
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\vax\');
        connectorType = 'vax' 
        SetTitle = 'Dyson V6 [SetName]'
        ConnectorTitle = 'Dyson V6'
        Options = @();
        HueMin = 310   #min value is 0
        HueMax = 355 #max value is 360
        SaturationMin = 60
        SaturationMax = 60
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\funnel\');
        connectorType = 'Funnels'
        SetTitle = 'Funnels [SetName]'
        ConnectorTitle = 'Funnels\n25mm to 200mm'
        Options = @();
        HueMin = 265   #min value is 0
        HueMax = 305 #max value is 360
        SaturationMin = 50
        SaturationMax = 50
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\funnel_offcenter\');
        ConnectorType = 'Offset Funnels'
        SetTitle = 'Offset Funnels\n[SetName]'
        ConnectorTitle = 'Offset Funnels\n25mm to 200mm'
        Options = @();
        HueMin = 265   #min value is 0
        HueMax = 305 #max value is 360
        SaturationMin = 80
        SaturationMax = 80
    },
    @{
        Path = (Join-Path $script:ScriptFolder '\generated\hose_nozzle\');
        ConnectorType = 'Hose Nozzles'
        SetTitle = 'Hose Nozzles\n[SetName]'
        ConnectorTitle = 'Hose Nozzles\n25.4mm(1in) to 114mm(4.5in)'
        Options = @();
        HueMin = 60   #min value is 0
        HueMax = 110 #max value is 360
        SaturationMin = 50
        SaturationMax = 50
    }
)

function GetConfigForConnectorSet([string]$configPath, [string]$relativePath)
{
    if(!(Test-Path -LiteralPath $configPath)){
        throw "Cant find config file $($configPath)"
    }
    
    $json = ((Get-Content -Path $configPath) | ConvertFrom-Json)
 
    $configset = ($json.connectorSets | Where-Object {$_.path -eq $relativePath} | Select-Object -First 1)
    return $configset
}

function GetConfigSubSetTitle([PSCustomObject]$config, [string]$setFolderName)
{
    if($config -ne $null){
        $result = ($config.subSets | Where-Object {$_.folder -eq $setFolderName} | Select-Object -First 1).display
    }
        
    if([string]::IsNullOrEmpty($result))
    {
        $result = $setFolderName.Replace('_', ' ')
    }

    return $result
}

function GetConfigSetTitle([PSCustomObject]$config, [string]$setParentFolderName)
{
    if($config -ne $null){
        $result = $config.display
    }
        
    if([string]::IsNullOrEmpty($result))
    {
        $result = $setParentFolderName.Replace('_', ' ')
    }

    return $result
}

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
        [string]$Tile = "",
        [double]$ratio = (4/3),
        $Files
    )

    Set-Location $Path
    Write-Host "Creating Montage TargetFilename:'$($TargetFilename)'`r`n`tpath:'$($Path)' `r`n`tfiles:$($Files)" -ForegroundColor Yellow
    
    if($Files.Count -gt 1)
    {
        if([string]::IsNullOrEmpty($Tile)){
            $tilex = [math]::Max([math]::Ceiling([math]::Sqrt($Files.Count*($ratio))), 1)
            $tiley = [math]::Ceiling($Files.Count/$tilex)
            $Tile = "$($tilex)x$($tiley)"
        }
        
        #create the montage of the images.
        # montage, trim to remove white space from images, -geometry256x256+2+2 add small border and keep all images the same size
        & $script:ImageMagickPath montage -geometry 256x256+2+2 -tile $Tile -trim $Files $TargetFilename
    }else{
        & $script:ImageMagickPath montage -geometry 256x256+2+2 -trim $FileFilters $TargetFilename
    }

    Start-Sleep -Seconds 3
    return Get-Item -LiteralPath (Join-Path $Path $TargetFilename) 
}

function Add-ImageCaption{
    param(
        [Parameter(ValueFromPipeline=$true)]
        [System.IO.FileInfo]$ImageFile,
        [string]$Title,
        [int]$PointRatio,
        [decimal]$Position = 1/6
    )

    Write-Host "Add-ImageCaption ImageFile:'$($ImageFile.FullName)'`r`n`tfiles:$($Title)" -ForegroundColor Yellow
    Set-Location $ImageFile.Directory.FullName

    #get the image size
    $width = [System.Convert]::ToInt16((& $script:ImageMagickPath identify -format %w $ImageFile.Name))
    $height = [System.Convert]::ToInt16((& $script:ImageMagickPath identify -format %h $ImageFile.Name))
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
    & $script:ImageMagickPath convert -resize "$($percentage)%" -background '#000b' -geometry "+0+$($ofset)" -fill white -gravity center -pointsize $pointsize -size $width caption:"$($Title)" $ImageFile.Name +swap -gravity south -composite $ImageFile.Name
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

#$configPath  = '\\10.0.0.11\general\projects\3d_printing\vacuum-hose-adapter-openscad\info.json'
#$relativePath = 'camlock\nozzles'   
#$config = GetConfigForConnectorSet $configPath $relativePath 
#$setFolderName = 'nozzle_square_wide'
#GetConfigSubSetTitle $config 'nozzle_square_wide'
#GetConfigSetTitle $config 'nozzle'


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

            $saturation = $SourceSettings.SaturationMin
            if((join-path $stl.Directory.Parent.FullName '') -ine (join-path $SourceSettings.Path ''))
            {
                $parentSet = $stl.Directory.Parent.Name
                $folderSets = (Get-ChildItem -LiteralPath $SourceSettings.Path -Directory ) | Where-Object {$_.Name -ne 'thumb'} | Select-Object -ExpandProperty Name | Sort-Object @{Expression = { 
                    $number = ($_ -replace '(\d+\.?\d*).*', '$1')
                    [decimal]$dec = 0
                    if([decimal]::TryParse($number, [ref]$dec))
                    {
                        return $dec
                    }
                    else{
                        $_ 
                    }}}

                $saturation = $SourceSettings.SaturationMax - [Math]::Floor([array]::indexof($folderSets, $parentSet) * ($SourceSettings.SaturationMax - $SourceSettings.SaturationMin) / ($folderSets.Length - 1))
            }

            $colour = ConvertFrom-Hsl $hue $saturation 60 -ABGR
            $colour2 = ConvertFrom-Hsl $hue $saturation 20 -ABGR

            write-host "$($stl.FullName) hue:[$($SourceSettings.HueMin):$($SourceSettings.HueMax):$hue] saturation:[$($SourceSettings.SaturationMin):$($SourceSettings.SaturationMax):$saturation] $colour2 $colour"
            & $script:StlThumbPath --material $colour2 $colour 111111 $($stl.FullName) $targetPath
            
            if($LASTEXITCODE -gt 0)
            {
                Write-Warning "$($stl.FullName) failed"
                Rename-Item -LiteralPath $stl.FullName -NewName "$($stl.Name)$([datetime]::Now.ToString('yyyyMMddhhmmss')).broken"
            }
            
        }
    }

    # Create thunbnail sets
    Get-ChildItem -LiteralPath $SourceFolder -Recurse -Filter 'thumb' -Directory | ForEach-Object { 
        $thumbFolder = $_

        $relativePath = $thumbFolder.FullName.Replace($sourceFolderItem.Parent.FullName, '').Replace('\thumb', '') #'camlock\nozzles'   
        $config = GetConfigForConnectorSet $script:configPath $relativePath 

        # Thunbnails for sub folders.
        Get-ChildItem -LiteralPath $thumbFolder.FullName -Directory  | ForEach-Object {
            $folder = $_
            
            $setName = $folder.Name
            $title = $SourceSettings.SetTitle. `
                Replace('[SetName]', (GetConfigSubSetTitle $config $setName)). `
                Replace('[ParentFolderName]',(GetConfigSetTitle $config $thumbFolder.Parent.Name));

            Write-Verbose "$($folder.FullName) | $title"
      
            $targetFileName = "$($setName)_display.jpg"
            $newestFile = Get-ChildItem -LiteralPath $folder.FullName | Sort-Object LastAccessTime -Descending | Select-Object -First 1
            $generateThumb = GenerationNeeded (Join-Path $thumbFolder.FullName $targetFileName) $newestFile

            # for each child folder add wild card search, sort them by the number value (so 20 comes before 100)
            $files = Get-ChildItem -LiteralPath $folder.FullName -Filter '*.png' `
                | Sort-Object @{Expression = { 
                    $number = ($_.Name -replace '.*?(\d+\.?\d*).*', '$1')
                    [decimal]$dec = 0
                    if([decimal]::TryParse($number, [ref]$dec))
                    {
                        return $dec
                    }
                    else{
                        $_ 
                    }
                }} `
                | Select-Object @{name='Name';expression={$_.FullName.Replace("$($thumbFolder.FullName)\", '')}} `
                | Select-Object -ExpandProperty Name
           

            if($generateThumb -or $Script:ForceRegeneration) {
                # montage, trim to remove white space from inages, -geometry +2+2 add small border
                #& $script:ImageMagickPath montage -adjoin -geometry +2+2 -trim -title "$($title)" 
                Create-Montage -Path $thumbFolder.FullName `
                    -TargetFilename $targetFileName `
                    -Files $files `
                    | Add-ImageCaption -Title $title -PointRatio 17

            }
            else{
                Write-Verbose "Skipping file set $($title)"
            }
        }

        $stlCount = (Get-ChildItem $thumbFolder.Parent.FullName -Recurse -Filter *.stl).Length

        $title = $SourceSettings.ConnectorTitle. `
                Replace('[SetName]', (GetConfigSubSetTitle $config $folder.Name)). `
                Replace('[ParentFolderName]',(GetConfigSetTitle $config $thumbFolder.Parent.Name))

        # for each child folder add wild card search, sort them by the number value (so 20 comes before 100)
        $files = Get-ChildItem -LiteralPath $thumbFolder.FullName -Directory | ForEach-Object {
                Get-ChildItem -LiteralPath $_.FullName -Filter '*.png' `
                | Sort-Object @{Expression = { 
                    $number = ($_.Name -replace '.*?(\d+\.?\d*).*', '$1')
                    [decimal]$dec = 0
                    if([decimal]::TryParse($number, [ref]$dec))
                    {
                        return $dec
                    }
                    else{
                        $_ 
                    }
                }} `
                | Select-Object @{name='Name';expression={$_.FullName.Replace("$($thumbFolder.FullName)\", '')}} `
                | Select-Object -ExpandProperty Name
            }

           #| Sort-Object {[decimal]($_ -replace '(\d+\.?\d*).*', '$1')}
         #$filesString = $files | Join-String -Separator " "

        Write-Host "$($thumbFolder.FullName) | $title"

    
        $newestFile = Get-ChildItem $thumbFolder.Parent.FullName -Recurse -Filter *.stl | Sort-Object LastAccessTime -Descending | Select-Object -First 1
      
        $targetFileName = "display.jpg"
        $generateCompleteSet = GenerationNeeded  (Join-Path $thumbFolder.FullName $targetFileName) $newestFile
        if($generateCompleteSet -or $Script:ForceRegeneration) {
            # montage, trim to remove white space from inages, -geometry256x256+2+2 add small border and keep all images the same size
            #& $script:ImageMagickPath montage -geometry 256x256+2+2 -pointsize 24 -trim -title "$($title)" $files display.webp
            Create-Montage -Path $thumbFolder.FullName `
                -TargetFilename $targetFileName `
                -Files $files `
                | Add-ImageCaption -Title $title -PointRatio 14
        }
        else{
                  Write-Verbose "Skipping thunbnail complete set $($title)"
        }
        
        $targetFileName = "display_$($script:SummarySetCount).jpg"
        $generateSummarySet = GenerationNeeded (Join-Path $thumbFolder.FullName $targetFileName) $newestFile
        if($generateSummarySet -or $Script:ForceRegeneration) {
            # thumb for a random selection
            $files = Get-ChildItem -LiteralPath $thumbFolder.FullName -Recurse -Filter '*.png' `
                | Sort-Object { Get-Random } `
                | select -First $script:SummarySetCount `
                | Select-Object @{name='Name';expression={"$($_.Directory.Name)\$($_.Name)"}} `
                | Select-Object -ExpandProperty Name

            Write-Verbose "$($thumbFolder.FullName) | $title | thunbnail summary set $($script:SummarySetCount)"
            Create-Montage -Path $thumbFolder.FullName `
                -TargetFilename $targetFileName `
                -Tile $script:SummarySetTile `
                -Files $files `
                | Add-ImageCaption -Title $title -PointRatio 14
        }
        else{
            Write-Verbose "Skipping thunbnail summary set $($title)"
        }
    }

    $title = $SourceSettings.ConnectorType

    # thumb for a random selection
    $files = Get-ChildItem -LiteralPath $sourceFolder -Recurse -Filter '*.png' `
        | Sort-Object { Get-Random } `
        | select -First $script:SummarySetCount `
        | Select-Object @{name='Name';expression={"$($_.Directory.FullName)\$($_.Name)"}} `
        | Select-Object -ExpandProperty Name
    Write-Host "$($sourceFolder) | $($Options.ConnectorType) | thunbnail summary set $takeCount"
    Create-Montage -Path $sourceFolder `
        -TargetFilename "display_$($takeCount)_$([datetime]::Now.ToString('yyyyMMddHHmmss')).jpg" `
        -Tile $script:SummarySetTile `
        -Files $files `
        | Add-ImageCaption -Title $title -PointRatio 12

}


$title = 'hose connectors'

# thumb for a random selection
$takeCount = 42
$tile = '8x6'
$path = (Join-Path $script:ScriptFolder '\generated')
cd $path
$files = Get-ChildItem -LiteralPath $path -Recurse -Filter '*.png' | Sort-Object { Get-Random } | select -First $takeCount | Select-Object @{name='Name';expression={"$($_.Directory.FullName)\$($_.Name)"}} | Select-Object -ExpandProperty Name
Write-Host "$($path) | $title | thunbnail summary set $takeCount"
Create-Montage -Path $path `
    -TargetFilename "display_$($takeCount)_$([datetime]::Now.ToString('yyyyMMddHHmmss')).jpg" `
    -Tile $tile `
    -Files $files `
    | Add-ImageCaption -Title $title -PointRatio 10

