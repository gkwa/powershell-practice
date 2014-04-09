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
[void]$new_anchor.AppendChild($install_app_node)

# next, clone the empty "Install Applications" node in the new "Install
# Applications" group and add an application guid there
$group = $xml.SelectNodes('//group') | where { $_.name -eq 'Install Applications' }
$install_step  = $group.ChildNodes | where { $_.name -eq 'Install Applications' }
$tmp = $install_step.CloneNode($true)

$var = $tmp.defaultVarList.variable[0]
# We'd pull this guid from the Applications.xml file
$var.InnerText='{0e7c2dca-10ac-48c3-aa0b-4502bd2dd1a1}'

[void]$group.appendchild($tmp)

$xml.Save("${file}.result")
