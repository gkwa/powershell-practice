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
$xml = [XML](Get-Content $xmlFile)

[System.Xml.XmlNamespaceManager]$nsmgr=$xml.NameTable
$nsmgr.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$nsmgr.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")

$newElement = $xml.CreateElement("Disk", $nsmgr.LookupNamespace("urn"))
[void]$newElement.SetAttribute("action", $nsmgr.LookupNamespace("wcm"), "add")

$child1 = $xml.CreateElement("CreatePartitions",$nsmgr.LookupNamespace("urn"))
[void]$child1.SetAttribute("action", $nsmgr.LookupNamespace("wcm"), "add")

$child2 = $xml.CreateElement("ModifyPartitions",$nsmgr.LookupNamespace("urn"))
$child3 = $xml.CreateElement("DiskID",$nsmgr.LookupNamespace("urn"))
$child3.InnerText = "0"
$child4 = $xml.CreateElement("WillWipeDisk",$nsmgr.LookupNamespace("urn"))
$child4.InnerText = "true"
[void]$newElement.AppendChild($child1)
[void]$newElement.AppendChild($child2)
[void]$newElement.AppendChild($child3)
[void]$newElement.AppendChild($child4)
$xml.Save("${file}.result")



$child1.outerxml