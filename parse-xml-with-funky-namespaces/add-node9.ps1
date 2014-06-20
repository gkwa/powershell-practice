<#

powershell SelectNodes where name

#>

function add_touch_capture_complete_sentinal_file($task_file_abspath)
{
    $file = $task_file_abspath
    $xml = [xml](Get-Content $file)

    $step_cli = $xml.SelectNodes('//step') | where { $_.name -match "Create WIM" }
    $clone_cli = $step_cli.cloneNode($false)
    [void]$clone_cli.SetAttribute("name", "", "Create Capture Complete Sentinal file")
    [void]$clone_cli.SetAttribute("disable", "", "false")
    $action = $xml.CreateElement("action")
    $action.InnerText = "cmd /c echo %TIME% > %BackupShare%\%BackupDir%\capture_complete.txt"
    [void]$clone_cli.appendChild($action)

    # Add this new touch-sentinel-file step to end of Capture Image step group
    $group = ($xml.SelectNodes('//group') | where { $_.name -eq "Capture Image" })[1]
    [void]$group.InsertAfter($clone_cli, $group.LastChild)

    $xml.Save("$file.result")
}

$task_file_abspath = "ts2.xml"
add_touch_capture_complete_sentinal_file $task_file_abspath
