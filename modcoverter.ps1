#"D:\Downloads\Games\SkyrimManualMods\LEVersion" oldrim veriosn, Legendary Endition version
$pathWhereYouDowloadModsArchiveLEVersion="D:\Downloads\Games\SkyrimManualMods\LEVersion"
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Get-ChildItem $pathWhereYouDowloadModsArchiveLEVersion\* -Include *.zip, *.rar, *.7z | Foreach-Object {
     echo 'Extarcting Archive to folder with the same names ...'
     $destPath=($_.FullName).split(".")[0] #split return arrayobject take first element without externsion (from zero)
     $destPath=($destPath).split("-")[0] #just delete unnesseassary sybmo
     if (($destPath).split(" ").Count -gt 1) {
         $destPath1=($destPath).split(" ")[0]
         $destPath2=($destPath).split(" ")[1]
         $destPath3=($destPath).split(" ")[2] #just delete unnesseassary sybmo
         $destPath="$($destPath1)$($destPath2)$($destPath3)"
     }
     $command7zX="7z.exe x '$($_.FullName)' -o$($destPath)"
     Invoke-Expression $command7zX 
     if ( (Get-ChildItem -Path $destPath -force | Where-Object Extension -in ('.bsa') | Measure-Object).Count -eq 1 )
        {
            cd $destPath
            $commandBSA="bsarch.exe unpack $($destPath)\$(@(gci *.bsa)[0].Name) $($destPath) "
            Invoke-Expression $commandBSA
            if ($?) {
                #rm @(gci *.bsa)[0].Name
                cp "NifScan.exe" $destPath\NifScan.exe
                $commandNifScan="$($destPath)\NifScan.exe -fixdds"
                Invoke-Expression $commandNifScan
                if ($?) {
                    rm $destPath\NifScan.exe
                }
            }
        }

    cp "$($scriptPath)\converttoskyrimSE.bat" "$($destPath)\converttoskyrimSE.bat"
    cp "$($scriptPath)\HavokBehaviorPostProcess.exe" "$($destPath)\HavokBehaviorPostProcess.exe"
    start $destPath\converttoskyrimSE.bat -Wait
    rm $destPath\converttoskyrimSE.bat
    rm $destPath\HavokBehaviorPostProcess.exe
    $command="7z.exe a $($destPath)_SSE_Converted.7z $($destPath)\*"
    Invoke-Expression $command
     if ($?) { 
    #   Get-ChildItem -Recurse -File | Where {($_.Extension -ne ".7z")} | Remove-Item 
    #   Get-ChildItem -Recurse -File | Where {($_.Extension -ne ".7z")} | Remove-Item
    Remove-Item -recurse $destPath\* -exclude "$($destPath)'.7z"
    rm $destPath
     }
     }
 
