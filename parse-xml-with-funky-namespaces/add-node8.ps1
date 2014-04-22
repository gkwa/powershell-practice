# Creates this:
# <component name="Networking-MPSSVC-Svc" processorArchitecture="x86" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
#     <FirewallGroups>
#         <FirewallGroup wcm:action="add" wcm:keyValue="RemoteDesktop">
#             <Group>Remote Desktop</Group>
#             <Profile>all</Profile>
#             <Active>true</Active>
#         </FirewallGroup>
#     </FirewallGroups>
# </component>




<#

powershell xmlns:wcm ImportNode InnerText

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

$settings = $xml.SelectSingleNode('//urn:settings[@pass="specialize"]', $ns)

if(!($settings.component | where { $_.name -eq 'Networking-MPSSVC-Svc' }))
{
    $component = $settings.component[0].clonenode($false)
    [void]$component.SetAttribute("name", 'Networking-MPSSVC-Svc')

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
    [void]$component.AppendChild($fwgroup1)
    $component.outerxml

    [void]$settings.appendChild($component)
}

$xml.Save("${filename}.result")
