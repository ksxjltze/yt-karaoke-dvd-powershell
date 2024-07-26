$ConvertToDVDScript = "D:\Scripts\karaoke\karaoke_dvd.py"
$PanAudioLRScript = "karaoke_pan_LR.py"

$AudacityPath = "C:\Program Files\Audacity\Audacity.exe"

& $PSScriptRoot\Select_Folder.ps1

$OriginalAudioPath = $FolderBrowser.SelectedPath + "\" + @(dir .\ -recurse -Path $FolderBrowser.SelectedPath | where {$_.extension -in ".m4a",".opus"})[0]
$MinusVocalsPath = $FolderBrowser.SelectedPath + "\separated"
$KaraokeAudioPath = @(gci *.mp3 -Path $FolderBrowser.SelectedPath -recurse | % { $_.FullName })[0]
$CombinedOutputPath = ($FolderBrowser.SelectedPath + "\karaoke.ac3")

& $PSScriptRoot\Convert_LR_mp3.ps1

$OriginalVideoPath = $FolderBrowser.SelectedPath + "\" + @(gci *.mp4 -Path $FolderBrowser.SelectedPath)[0]
$OutputVideoPath = [System.IO.Path]::ChangeExtension($OriginalVideoPath, ".mpeg")

& $PSScriptRoot\Convert_DVD.ps1

Read-Host -Prompt "Press Enter to exit"