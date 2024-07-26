$ConvertToDVDScript = "D:\Scripts\karaoke\karaoke_dvd.py"
$PanAudioLRScript = "karaoke_pan_LR.py"

$AudacityPath = "C:\Program Files\Audacity\Audacity.exe"
$AvidemuxCLI = avidemux_cli

& $PSScriptRoot\Select_Folder.ps1
& $PSScriptRoot\Convert_LR_mp3.ps1

$OriginalVideoPath = $FolderBrowser.SelectedPath + "\" + @(gci *.mp4 -Path $FolderBrowser.SelectedPath)[0]
$KaraokeAudioPath = ($FolderBrowser.SelectedPath + "\karaoke.ac3")
$OutputVideoPath = [System.IO.Path]::ChangeExtension($OriginalVideoPath, ".mpeg")

Write-Host $OriginalVideoPath 
Write-Host $KaraokeAudioPath 
Write-Host $OutputVideoPath 

Read-Host -Prompt "Press Enter to exit"