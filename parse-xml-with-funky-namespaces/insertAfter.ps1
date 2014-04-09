# find 'Install Applications' step and put it inside a new 'Install Applications' group

$file = "ts.xml" # FIXME: don't hardcode task sequence id
$xml = [xml](Get-Content $file)
$step_anchor = $xml.SelectNodes('//step') | where { $_.name -eq 'Install Applications' }

$group_xml = [xml]@"
<group name="Install Applications"
       disable="false"
       continueOnError="false"
       expand="false"
       description="Install Applications"></group>
"@

[System.Xml.XmlElement]$elem = $group_xml.get_DocumentElement()
[System.Xml.XmlNode]$stepB = $xml.ImportNode($elem, $True)
$new_anchor = $step_anchor.ParentNode.InsertAfter($stepB, $step_anchor)
$install_app_node = $step_anchor.ParentNode.RemoveChild($step_anchor)
$new_anchor.AppendChild($install_app_node)

$xml.Save("${file}.result")
