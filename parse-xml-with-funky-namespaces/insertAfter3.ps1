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
$step_restart = ($xml.SelectNodes('//step') | where { $_.name -eq 'Restart computer' })[0]
$clone_restart = $step_restart.cloneNode($true)
[void]$group_anchor.ParentNode.InsertAfter($clone_restart, $group_anchor)

[System.Xml.XmlElement]$clone2 = $step_restart.cloneNode($true)
[void]$clone2.SetAttribute("name", "", "Shutdown computer")
[void]$clone2.SetAttribute("startIn", "", "%WINDIR%\System32")
$clone2.SelectSingleNode("./action[1]").'#text' = 'shutdown -t 0 -s'
[void]$clone_restart.ParentNode.InsertAfter($clone2, $clone_restart)

$xml.Save("${file}.result")
