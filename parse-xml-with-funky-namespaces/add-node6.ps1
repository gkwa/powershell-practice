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

[System.Xml.XmlNamespaceManager]$ns =$xml.NameTable
$ns.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$ns.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")

# <Disk wcm:action="add">
$NewDisk = $xml.CreateElement("Disk", $ns.LookupNamespace("urn"))
[void]$NewDisk.SetAttribute("action", $ns.LookupNamespace("wcm"),"add")
# <CreatePartitions>
$ChildCreatePartitions = $xml.CreateElement("CreatePartitions", $ns.LookupNamespace("urn"))
[void]$NewDisk.AppendChild($ChildCreatePartitions)

# <CreatePartition wcm:action="add">
$ChildCreatePartition  = $xml.CreateElement("CreatePartition",$ns.LookupNamespace("urn"))
[void]$ChildCreatePartition.SetAttribute("action", $ns.LookupNamespace("wcm"),"add")
[void]$ChildCreatePartitions.AppendChild($ChildCreatePartition)

# <Order>1</Order>
$ChildOrder = $xml.CreateElement("Order", $ns.LookupNamespace("urn"))
$ChildOrder.InnerText = "1"
[void]$ChildCreatePartition.AppendChild($ChildOrder)

# <Type>Primary</Type>
$ChildType = $xml.CreateElement("Type", $ns.LookupNamespace("urn"))
$ChildType.InnerText = "Primary"
[void]$ChildCreatePartition.AppendChild($ChildType)

# <Extend>true</Extend>
$ChildExtend = $xml.CreateElement("Extend", $ns.LookupNamespace("urn"))
$ChildExtend.InnerText = "true"
[void]$ChildCreatePartition.AppendChild($ChildExtend)

# <ModifyPartitions>
$ChildModifyPartitions = $xml.CreateElement("ModifyPartitions", $ns.LookupNamespace("urn"))
[void]$NewDisk.AppendChild($ChildModifyPartitions)

# <ModifyPartition wcm:action="add">
$ChildModifyPartition  = $xml.CreateElement("ModifyPartition",$ns.LookupNamespace("urn"))
[void]$ChildModifyPartition.SetAttribute("action", $ns.LookupNamespace("wcm"),"add")
[void]$ChildModifyPartitions.AppendChild($ChildModifyPartition)

# <Format>NTFS</Format>
$ChildFormat = $xml.CreateElement("Format", $ns.LookupNamespace("urn"))
$ChildFormat.InnerText = "NTFS"
[void]$ChildModifyPartition.AppendChild($ChildFormat)

# <Label>Software</Label>
$ChildLabel = $xml.CreateElement("Label", $ns.LookupNamespace("urn"))
$ChildLabel.InnerText = "Data"
[void]$ChildModifyPartition.AppendChild($ChildLabel)

# <Order>1</Order>
$ChildOrder = $xml.CreateElement("Order", $ns.LookupNamespace("urn"))
$ChildOrder.InnerText = "1"
[void]$ChildModifyPartition.AppendChild($ChildOrder)

# <PartitionID>1</PartitionID
$ChildPartitionID = $xml.CreateElement("PartitionID", $ns.LookupNamespace("urn"))
$ChildPartitionID.InnerText = "1"
[void]$ChildModifyPartition.AppendChild($ChildPartitionID)

# <DiskID>0</DiskID>
$ChildDiskID = $xml.CreateElement("DiskID", $ns.LookupNamespace("urn"))
$ChildDiskID.InnerText = "1" # must be unique in the xml file !
[void]$NewDisk.AppendChild($ChildDiskID)

# <WillWipeDisk>true</WillWipeDisk>
$ChildWipe = $xml.CreateElement("WillWipeDisk", $ns.LookupNamespace("urn"))
$ChildWipe.InnerText = "true"
[void]$NewDisk.AppendChild($ChildWipe)

if(-not $xml.SelectSingleNode("//DiskConfiguration"))
{
    $NewDiskConfig = $xml.CreateElement("DiskConfiguration", $ns.LookupNamespace("urn"))
    [void]$NewDiskConfig.AppendChild($NewDisk)

    $Component = $xml.SelectSingleNode("//urn:component[name='Microsoft-Windows-Setup']")
    $Component.AppendChild($NewDiskConfig)
}
$xml.Save("${file}.result")
