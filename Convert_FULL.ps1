$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding =
                    New-Object System.Text.UTF8Encoding

$script:ConvertToDVDScript = "karaoke_dvd.py"

$script:SourceURL = Read-Host "Enter YouTube URL"
Write-Host "Select a Folder to save the files to:"
& $PSScriptRoot\Select_Folder.ps1

$script:DirectoryPath = $FolderBrowser.SelectedPath

$script:VideoTitle = (yt-dlp --skip-download --print title $SourceURL)
$VideoTitle = $VideoTitle.Replace("/", "")
$VideoTitle = $VideoTitle.Replace("\", "")

$script:VideoDirectory = $DirectoryPath + "\" + $VideoTitle

New-Item -ItemType Directory -Force -Path $VideoDirectory

& $PSScriptRoot\Download_Youtube.ps1

$script:OriginalAudioPath = $VideoDirectory + "\" + @(Get-ChildItem .\ -recurse -Path $VideoDirectory | Where-Object {$_.extension -in ".m4a",".opus"})[0]
$script:MinusVocalsPath = $VideoDirectory + "\separated"

& $PSScriptRoot\Minus_Vocals.ps1

$script:KaraokeAudioPath = @(Get-ChildItem *.mp3 -Path $VideoDirectory -recurse | ForEach-Object { $_.FullName })[0]
$script:CombinedOutputPath = ($VideoDirectory + "\karaoke.ac3")

& $PSScriptRoot\Convert_LR_mp3.ps1

$script:OriginalVideoPath = $VideoDirectory + "\" + @(Get-ChildItem *.mp4 -Path $VideoDirectory)[0]
$script:OutputVideoPath = [System.IO.Path]::ChangeExtension($OriginalVideoPath, ".mpeg")

& $PSScriptRoot\Convert_DVD.ps1

Read-Host -Prompt "Press Enter to exit"