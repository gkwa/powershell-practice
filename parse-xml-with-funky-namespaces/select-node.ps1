$file = "Unattend.xml"
$xmlFile = $file
[xml]$xmlDoc = Get-Content $xmlFile
$ns = new-object Xml.XmlNamespaceManager $xmlDoc.NameTable
$ns.AddNamespace('dns', 'urn:schemas-microsoft-com:unattend')
$node = $xmlDoc.SelectSingleNode("//dns:component[@name='Microsoft-Windows-IE-InternetExplorer']", $ns)
$node
