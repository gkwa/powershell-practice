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

$file = "Unattend.xml"
$xmlFile = $file
[xml]$xmlDoc = Get-Content $xmlFile

$xml = [XML](Get-Content "Unattend.xml")

[System.Xml.XmlNamespaceManager]$nsmgr =$xml.NameTable
$nsmgr.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$nsmgr.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")

$newElement = $xml.CreateElement("Disk", $nsmgr.LookupNamespace("urn"))
[void]$newElement.SetAttribute("action", $nsmgr.LookupNamespace("wcm"), "add")
$child1 = $xml.CreateElement("CreatePartitions")
$child2 = $xml.CreateElement("ModifyPartitions")
$child3 = $xml.CreateElement("DiskID")
$child3.InnerText = "5"
$child4 = $xml.CreateElement("WillWipeDisk")
$child4.InnerText = "false"
[void]$newElement.AppendChild($child1)
[void]$newElement.AppendChild($child2)
[void]$newElement.AppendChild($child3)
[void]$newElement.AppendChild($child4)
write-host  "before"
$xml.unattend.settings.component.DiskConfiguration
$xml.unattend.settings.component.DiskConfiguration.AppendChild($newElement)
write-host "after"
$xml.unattend.settings.component.DiskConfiguration
$xml.save(".\toto.xml")

$xmlDoc.Save("${file}.result")
