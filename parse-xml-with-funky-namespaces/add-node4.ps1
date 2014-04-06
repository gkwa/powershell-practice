<#
SelectNodes Select-Object  Expand name

powershell xmlns:wcm
xmlns:wcm
xmlns:xsi

powershell get_DocumentElement appendchild
powershell appendchild DocumentElement namespace
powershell appendchild DocumentElement namespace importnode

http://social.technet.microsoft.com/Forums/scriptcenter/en-US/405bd5ba-cb35-4ef6-8a7d-bc4846e5ce8f/adding-a-disk-section-in-a-existing-unattendxml-file-using-powershell?forum=winserverpowershell

#>

$file = "Unattend.xml"
$xmlFile = $file
[xml]$xmlDoc = Get-Content $xmlFile

[System.Xml.XmlNamespaceManager]$ns =$xmlDoc.NameTable
$ns.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
# $tmp = $xml.SelectSingleNode("//urn:Disk[urn:DiskID=1]", $ns)
# $tmp = $xmlDoc.SelectSingleNode("//dns:component[0]",$ns)
$tmp = $xml.SelectSingleNode("//urn:component", $ns)

$tmp


exit


$clone = $xmlDoc.unattend.settings[0].component[0].clonenode($false)
$clone.GetType()
$cloneDoc = [xml]$clone.outerxml

$cloneDoc
$cloneDoc.GetType()

$newxml = [xml]@"
<fDenyTSConnections>false</fDenyTSConnections>
"@

$newxml.GetType()

$newNode = $cloneDoc.ImportNode($newxml.DocumentElement,$true)
([xml]$cloneDoc).DocumentElement.AppendChild($newNode)
([xml]$cloneDoc).outerxml
# [xml]$cloneDoc..AppendChild($newNode)

exit




<#

[System.Xml.XmlNode]$compNode = $xmlDoc.ImportNode($elem, $True)
[void]$xmlDoc.SelectSingleNode("//dns:settings[@pass='specialize']/dns:*",$ns).ParentNode.AppendChild($compNode)

[System.Xml.XmlNode]$compNode = $xmlDoc.ImportNode($elem, $True)
[void]$xmlDoc.SelectSingleNode("//dns:settings[@pass='offlineServicing']/dns:*",$ns).ParentNode.AppendChild($compNode)

[System.Xml.XmlNode]$compNode = $xmlDoc.ImportNode($elem, $True)
[void]$xmlDoc.SelectSingleNode("//dns:settings[@pass='generalize']/dns:*",$ns).ParentNode.AppendChild($compNode)

#>



$xmlDoc.Save("${file}.result")
