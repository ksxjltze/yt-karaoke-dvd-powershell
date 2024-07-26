Start-Process -FilePath $AudacityPath
Start-Sleep -Seconds 3.0

python $PanAudioLRScript $FolderBrowser.SelectedPath