<#

powershell xmlns:wcm ImportNode

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

$filename = "Unattend.xml"
[xml]$xml = (gc $filename)

[System.Xml.XmlNamespaceManager]$ns = $xml.NameTable
$ns.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$ns.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")

# $pass = ($xml.SelectNodes('//urn:settings',$ns) | where { $_.pass -eq 'specialize' })[0]
$settings = $xml.SelectSingleNode('//urn:settings[@pass="specialize"]',$ns)

# $networking = $pass.SelectSingleNode('./urn:component',$ns) | where { $_.name -eq 'Networking-MPSSVC-Svc' }
# $networking = $pass.SelectSingleNode('./urn:component/*',$ns)
$networking = $settings.component | where { $_.name -eq 'Networking-MPSSVC-Svc' }
if(!$networking)
{
    $component = $settings.component[0].clonenode($false)
    # $settings.addChild(
    $component.outerxml
    $fwgroup=[xml]@"
<FirewallGroups>
    <FirewallGroup wcm:action="add" wcm:keyValue="RemoteDesktop">
	<Group>Remote Desktop</Group>
	<Profile>all</Profile>
	<Active>true</Active>
    </FirewallGroup>
</FirewallGroups>
"@
#    $newNode = $xml.ImportNode($fwgroup.DocumentElement,$true)

    # <Group>Remote Desktop</Group>
    $group = $xml.CreateElement("Group", $ns.LookupNamespace("urn"))
    $group.InnerText = "Remote Desktop"

    # <Profile>all</Profile>
    $profile = $xml.CreateElement("Profile", $ns.LookupNamespace("urn"))
    $profile.InnerText = "all"

    # <Active>true</Active>
    $active = $xml.CreateElement("Active", $ns.LookupNamespace("urn"))
    $active.InnerText = "true"

    # <FirewallGroup wcm:action="add" wcm:keyValue="RemoteDesktop">
    $fwgroup1 = $xml.CreateElement("FirewallGroup", $ns.LookupNamespace("urn"))
    [void]$fwgroup1.SetAttribute("action", $ns.LookupNamespace("wcm"), "add")
    [void]$fwgroup1.SetAttribute("RemoteDesktop", $ns.LookupNamespace("wcm"), "keyValue")

#     <FirewallGroups>
    $fwgroup = $xml.CreateElement("FirewallGroup", $ns.LookupNamespace("urn"))

    [void]$fwgroup1.AppendChild($group)
    [void]$fwgroup1.AppendChild($profile)
    [void]$fwgroup1.AppendChild($active)
    [void]$fwgroup.AppendChild($fwgroup1)

}


# <component name="Networking-MPSSVC-Svc" processorArchitecture="x86" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
#     <FirewallGroups>
#         <FirewallGroup wcm:action="add" wcm:keyValue="RemoteDesktop">
#             <Group>Remote Desktop</Group>
#             <Profile>all</Profile>
#             <Active>true</Active>
#         </FirewallGroup>
#     </FirewallGroups>
# </component>





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

$xml.Save("${filename}.result")
