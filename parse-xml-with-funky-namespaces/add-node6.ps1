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

[System.Xml.XmlNamespaceManager]$nsmgr =$xml.NameTable
$nsmgr.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$nsmgr.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")

# <Disk wcm:action="add">
$NewDisk = $xml.CreateElement("Disk", $nsmgr.LookupNamespace("urn"))
[void]$NewDisk.SetAttribute("action", $nsmgr.LookupNamespace("wcm"),"add")
# <CreatePartitions>
$ChildCreatePartitions = $xml.CreateElement("CreatePartitions", $nsmgr.LookupNamespace("urn"))
[void]$NewDisk.AppendChild($ChildCreatePartitions)

# <CreatePartition wcm:action="add">
$ChildCreatePartition  = $xml.CreateElement("CreatePartition",$nsmgr.LookupNamespace("urn"))
[void]$ChildCreatePartition.SetAttribute("action", $nsmgr.LookupNamespace("wcm"),"add")
[void]$ChildCreatePartitions.AppendChild($ChildCreatePartition)

# <Order>1</Order>
$ChildOrder = $xml.CreateElement("Order", $nsmgr.LookupNamespace("urn"))
$ChildOrder.InnerText = "1"
[void]$ChildCreatePartition.AppendChild($ChildOrder)

# <Type>Primary</Type>
$ChildType = $xml.CreateElement("Type", $nsmgr.LookupNamespace("urn"))
$ChildType.InnerText = "Primary"
[void]$ChildCreatePartition.AppendChild($ChildType)

# <Extend>true</Extend>
$ChildExtend = $xml.CreateElement("Extend", $nsmgr.LookupNamespace("urn"))
$ChildExtend.InnerText = "true"
[void]$ChildCreatePartition.AppendChild($ChildExtend)

# <ModifyPartitions>
$ChildModifyPartitions = $xml.CreateElement("ModifyPartitions", $nsmgr.LookupNamespace("urn"))
[void]$NewDisk.AppendChild($ChildModifyPartitions)

# <ModifyPartition wcm:action="add">
$ChildModifyPartition  = $xml.CreateElement("ModifyPartition",$nsmgr.LookupNamespace("urn"))
[void]$ChildModifyPartition.SetAttribute("action", $nsmgr.LookupNamespace("wcm"),"add")
[void]$ChildModifyPartitions.AppendChild($ChildModifyPartition)

# <Format>NTFS</Format>
$ChildFormat = $xml.CreateElement("Format", $nsmgr.LookupNamespace("urn"))
$ChildFormat.InnerText = "NTFS"
[void]$ChildModifyPartition.AppendChild($ChildFormat)

# <Label>Software</Label>
$ChildLabel = $xml.CreateElement("Label", $nsmgr.LookupNamespace("urn"))
$ChildLabel.InnerText = "Data"
[void]$ChildModifyPartition.AppendChild($ChildLabel)

# <Order>1</Order>
$ChildOrder = $xml.CreateElement("Order", $nsmgr.LookupNamespace("urn"))
$ChildOrder.InnerText = "1"
[void]$ChildModifyPartition.AppendChild($ChildOrder)

# <PartitionID>1</PartitionID
$ChildPartitionID = $xml.CreateElement("PartitionID", $nsmgr.LookupNamespace("urn"))
$ChildPartitionID.InnerText = "1"
[void]$ChildModifyPartition.AppendChild($ChildPartitionID)

# <DiskID>0</DiskID>
$ChildDiskID = $xml.CreateElement("DiskID", $nsmgr.LookupNamespace("urn"))
$ChildDiskID.InnerText = "1" # must be unique in the xml file !
[void]$NewDisk.AppendChild($ChildDiskID)

# <WillWipeDisk>true</WillWipeDisk>
$ChildWipe = $xml.CreateElement("WillWipeDisk", $nsmgr.LookupNamespace("urn"))
$ChildWipe.InnerText = "true"
[void]$NewDisk.AppendChild($ChildWipe)

[void]$xml.unattend.settings[0].component[0].DiskConfiguration.AppendChild($NewDisk)
$xml.Save("${file}.result")
