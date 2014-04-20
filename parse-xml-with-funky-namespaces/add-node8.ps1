<#
SelectNodes Select-Object  Expand name

powershell xmlns:wcm
xmlns:wcm
xmlns:xsi

powershell get_DocumentElement appendchild
powershell appendchild DocumentElement namespace
powershell appendchild DocumentElement namespace importnode
powershell createelement "same namespace"

http://stackoverflow.com/questions/135000/how-to-prevent-blank-xmlns-attributes-in-output-from-nets-xmldocument
http://social.technet.microsoft.com/Forums/scriptcenter/en-US/405bd5ba-cb35-4ef6-8a7d-bc4846e5ce8f/adding-a-disk-section-in-a-existing-unattendxml-file-using-powershell?forum=winserverpowershell

#>

$xml = [XML](gc "Unattend.xml")

[System.Xml.XmlNamespaceManager]$ns = $xml.NameTable
$ns.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$ns.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")

$settings = ($xml.SelectNodes('//urn:settings') | where { $_.pass -eq 'specialize' })[0]
$networking = $settings.SelectNodes('//urn:component') | where { $_.name -eq 'Networking-MPSSVC-Svc' }

$networking


# $clone_cli = $step_cli.cloneNode($false)
# [void]$clone_cli.SetAttribute("name", "", "Shutdown computer")
# [void]$clone_cli.SetAttribute("disable", "", "false")
# $action = $xml.CreateElement("action")
# $action.InnerText = "shutdown -t 0 -s"
# $clone_cli.appendChild($action)

# # Add the shutdown step to the last step of the Capture Image group
# $group = $xml.SelectNodes('//group') | where { $_.name -eq 'Capture Image' }
# [void]$group.InsertAfter($clone_cli, $group.LastChild)

# $xml.Save("${file}.result")



# # <fDenyTSConnections>
# $NewConn = $xml.CreateElement("fDenyTSConnections", $ns.LookupNamespace("urn"))
# $NewConn.InnerText = "false"

# # FIXME: why does component[0] have a different namespace than
# # component[1].  Should we specifically select the component that has
# # the right namespace according to Windows System Image Manager?
# $tmp = $xml.unattend.settings[0].component[1]
# $comp = $tmp.CloneNode($false)

# [void]$comp.AppendChild($NewConn)
# $comp.name = "Microsoft-Windows-TerminalServices-LocalSessionManager"

# $comp1 = $comp.cloneNode($true)
# $comp2 = $comp.cloneNode($true)
# $comp3 = $comp.cloneNode($true)

# # Enable remote desktop during Speclialize phase
# [void]$xml.SelectSingleNode("//urn:settings[@pass='specialize']", $ns).AppendChild($comp1)

# # Enable remote desktop during Offline Servicing phase
# [void]$xml.SelectSingleNode("//urn:settings[@pass='offlineServicing']", $ns).AppendChild($comp2)

# # Enable remote desktop during Generlize phase
# [void]$xml.SelectSingleNode("//urn:settings[@pass='generalize']", $ns).AppendChild($comp3)

$xml.Save("${file}.result")
