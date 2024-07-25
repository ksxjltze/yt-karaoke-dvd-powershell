Add-Type -AssemblyName System.Windows.Forms

$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$null = $FolderBrowser.ShowDialog()

Start-Process -FilePath "C:\Program Files\Audacity\Audacity.exe"
Start-Sleep -Seconds 2.0
python karaoke_pan.py $FolderBrowser.SelectedPath

Read-Host -Prompt "Press Enter to exit"