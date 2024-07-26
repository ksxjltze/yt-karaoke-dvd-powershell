Add-Type -AssemblyName System.Windows.Forms

$global:FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$null = $FolderBrowser.ShowDialog()
