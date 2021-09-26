#"D:\Downloads\Games\SkyrimManualMods\LEVersion" oldrim veriosn, Legendary Endition version
$pathWhereYouDowloadModsArchiveLEVersion="D:\Downloads\Games\SkyrimManualMods\LEVersion"
Get-ChildItem $pathWhereYouDowloadModsArchiveLEVersion\* -Include *.zip, *.rar, *.7z | Foreach-Object {
    Write-Host $_.FullName -ForegroundColor red -BackgroundColor yellow
     echo 'Extarcting Archive to folder with the same names ...'
     $destPath=($_.FullName).split(".")[0] #split return arrayobject take first element without externsion (from zero)
    Write-Host "Current destPath is:"$destPath -ForegroundColor red -BackgroundColor yellow
     $destPath=($destPath).split("-")[0] #just delete unnesseassary sybmo
     Write-Host "Current destPath is:"$destPath -ForegroundColor red -BackgroundColor yellow
     if (($destPath).split(" ").Count -gt 1) {
         $destPath1=($destPath).split(" ")[0]
         $destPath2=($destPath).split(" ")[1]
         $destPath3=($destPath).split(" ")[2] #just delete unnesseassary sybmo
         $destPath="$($destPath1)$($destPath2)$($destPath3)"
         Write-Host "Current destPath is:"$destPath -ForegroundColor red -BackgroundColor yellow
     }
     $command7zX="7z.exe x '$($_.FullName)' -o$($destPath)"
     Invoke-Expression $command7zX 
     if ( (Get-ChildItem -Path $destPath -force | Where-Object Extension -in ('.bsa') | Measure-Object).Count -eq 1 )
        {
            #"D:\Downloads\Games\SkyrimManualMods\modConvPlay\bsarch.exe"
            #@(gci *.bsa)[0]
            cd $destPath
            $commandBSA="D:\Downloads\Games\SkyrimManualMods\modConvPlay\bsarch.exe unpack $($destPath)\$(@(gci *.bsa)[0].Name) $($destPath) "
            Invoke-Expression $commandBSA
            if ($?) {
                #rm @(gci *.bsa)[0].Name
                cp "D:\Downloads\Games\SkyrimManualMods\modConvPlay\NifScan-75916-0-3-2\NifScan.exe" $destPath\NifScan.exe
                $commandNifScan="$($destPath)\NifScan.exe -fixdds"
                Invoke-Expression $commandNifScan
                if ($?) {
                    #rm $destPath\NifScan.exe
                }
            }
        }

    cp "D:\Downloads\Games\SkyrimManualMods\modConvPlay\Animation Converter\converttoskyrimSE.bat" "$($destPath)\converttoskyrimSE.bat"
    cp "D:\Downloads\Games\SkyrimManualMods\modConvPlay\Animation Converter\HavokBehaviorPostProcess.exe" "$($destPath)\HavokBehaviorPostProcess.exe"
    start $destPath\converttoskyrimSE.bat -Wait
    #.\converttoskyrimSE.bat
    #rm $destPath\converttoskyrimSE.bat
    #rm $destPath\HavokBehaviorPostProcess.exe
    echo "destPath $($delete) "
    $command="7z.exe a $($destPath).7z $($destPath)\*"
    Invoke-Expression $command
     if ($?) { 
    #   Get-ChildItem -Recurse -File | Where {($_.Extension -ne ".7z")} | Remove-Item 
    #   Get-ChildItem -Recurse -File | Where {($_.Extension -ne ".7z")} | Remove-Item
    Remove-Item -recurse $destPath\* -exclude "$($destPath)'.7z"
    #rm $destPath
     }
     }
 
