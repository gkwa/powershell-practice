# Add shutdown step as last step of the Create Image group of steps

<#

System.Xml.XmlElement SetAttribute clonenode
System.Xml set
powershell System.Xml innertext
powershell innertext clonenode
powershell SelectSingleNode #text versus innertext
powershell SelectSingleNode #text

#>

$file = "ts.xml"
$xml = [xml](Get-Content $file)

# Create shutdown step
$step_cli = ($xml.SelectNodes('//step') | where { $_.type -eq 'SMS_TaskSequence_RunCommandLineAction' })[0]
$clone_cli = $step_cli.cloneNode($false)
[void]$clone_cli.SetAttribute("name", "", "Shutdown computer")
[void]$clone_cli.SetAttribute("disable", "", "false")
$action = $xml.CreateElement("action")
$action.InnerText = "shutdown -t 0 -s"
$clone_cli.appendChild($action)

# Add the shutdown step to the last step of the Capture Image group
$group = $xml.SelectNodes('//group') | where { $_.name -eq 'Capture Image' }
[void]$group.InsertAfter($clone_cli, $group.LastChild)

$xml.Save("${file}.result")
