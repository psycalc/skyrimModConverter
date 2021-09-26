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
 


# $Myfile = 'Undergarments for all-49555-1-1.7z'
# $myfilenameWithoutExt= $Myfile.split(".")[0]
# $myfilenameWithoutExtAndMinus=$myfilenamewithoutext.split("-")[0]
# $currenLocation=(Get-Location).Path
# #Expand-Archive -LiteralPath $Myfile -DestinationPath .\$myfilenamewithoutext
# # If(!(test-path $myfilenameWithoutExtAndMinus))
# # {
# #     New-Item -Path "." -Name $myfilenameWithoutExtAndMinus -ItemType "directory"
# # }
# $destPath="$currenLocation\$myfilenameWithoutExtAndMinus"

# $fullpathToArchive=(-join($currenLocation, "\", $Myfile)) 
# #Write-Host "$($assoc.Id) - $($assoc.Name) - $($assoc.Owner)"
# $command="7z.exe x '$($fullpathToArchive)' -o'$($destPath)'"
# Invoke-Expression $command
# #D:\Downloads\Games\SkyrimManualMods\SSE NIF Optimizer-4089-3-0-14-1598206884\SSE NIF Optimizer.exe
# #(Get-ChildItem -Path $OutputPath -force | Where-Object Extension -in ('.txt','.ps1') | Measure-Object).Count
# #$value = Get-MysteryValue
# cd $destPath
# (Get-ChildItem -Path $OutputPath -force | Where-Object Extension -in ('.bsa','.esp') | Measure-Object).Count
# if ( (Get-ChildItem -Path $OutputPath -force | Where-Object Extension -in ('.bsa','.esp') | Measure-Object).Count -eq 1 )
# {
#     # do something
# } 
# if ( (Get-ChildItem -Path $OutputPath -force | Where-Object Extension -in ('.bsa','.esp') | Measure-Object).Count -eq 0 )
# {
#     cd data
#     (Get-ChildItem -Path $OutputPath -force | Where-Object Extension -in ('.bsa','.esp') | Measure-Object).Count
#     if ( (Get-ChildItem -Path $OutputPath -force | Where-Object Extension -in ('.bsa','.esp') | Measure-Object).Count -eq 1 )
#     {
#         #может быть мод только с Есп файлом, если есть хотя бы один бса файл передаем его командлайн bsa unpacker
#         if ( (Get-ChildItem -Path $OutputPath -force | Where-Object Extension -in ('.bsa') | Measure-Object).Count -eq 1 )
#         {
#             echo 'Unpack archive into the specified folder'
#             echo 'bsarch unpack d:\mymod\new.bsa "d:\unpacked archive\data"'
#             echo 'Create Skyrim Special Edition compressed archive'
#             echo 'bsarch pack "d:\my mod\data" "d:\my mod\data\new.bsa" -sse -z'
#         }
#     }
# } 


# Get-ChildItem "C:\Users\gerhardl\Documents\My Received Files" -Filter *.zip | 
# Foreach-Object {
#     $content = Get-Content $_.FullName

#     #filter and save content to the original file
#     $content | Where-Object {$_ -match 'step[49]'} | Set-Content $_.FullName

#     #filter and save content to a new file 
#     $content | Where-Object {$_ -match 'step[49]'} | Set-Content ($_.BaseName + '_out.log')
# }

# -Filter only accepts a single string. -Include accepts multiple values, but qualifies the -Path argument. The trick is to append \* to the end of the path, and then use -Include to select multiple extensions. BTW, quoting strings is unnecessary in cmdlet arguments unless they contain spaces or shell special characters.

# Get-ChildItem $originalPath\* -Include *.gif, *.jpg, *.xls*, *.doc*, *.pdf*, *.wav*, .ppt*
# Note that this will work regardless of whether $originalPath ends in a backslash, because multiple consecutive backslashes are interpreted as a single path separator. For example, try:

# Get-ChildItem C:\\\\\Windows