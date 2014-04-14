# Add restart computer step directly after Imaging steps group

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
$group_anchor = $xml.SelectNodes('//group') | where { $_.name -eq 'Imaging' }
$step_cli = ($xml.SelectNodes('//step') | where { $_.type -eq 'SMS_TaskSequence_RunCommandLineAction' })[0]
$clone_cli = $step_cli.cloneNode($false)
[void]$clone_cli.SetAttribute("name", "", "Shutdown computer")
[void]$clone_cli.SetAttribute("disable", "", "false")
$action = $xml.CreateElement("action")
$action.InnerText = "shutdown -t 0 -s"
$clone_cli.appendChild($action)

[void]$group_anchor.ParentNode.InsertAfter($clone_cli, $group_anchor)

$xml.Save("${file}.result")
