<#

SelectNodes Select-Object  Expand name

#>

$file = "Unattend.xml"
$xmlFile = $file
[xml]$xmlDoc = Get-Content $xmlFile

$ns = new-object Xml.XmlNamespaceManager $xmlDoc.NameTable
$ns.AddNamespace('dns', 'urn:schemas-microsoft-com:unattend')

$compxml = [xml]@"
<component name="Microsoft-Windows-RemoteAssistance-Exe"
	   processorArchitecture="x86"
	   publicKeyToken="31bf3856ad364e35"
	   language="neutral"
	   versionScope="nonSxS"
	   xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
	   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <fAllowFullControl>false</fAllowFullControl>
  <fAllowToGetHelp>false</fAllowToGetHelp>
</component>
"@

[System.Xml.XmlElement]$elem = $compxml.get_DocumentElement()
[System.Xml.XmlNode]$compNode = $xmlDoc.ImportNode($elem, $True)
[System.Xml.XmlElement]$x= $xmlDoc.SelectSingleNode("//dns:settings[@pass='specialize']/dns:*",$ns)
[void]$x.ParentNode.AppendChild($compNode)
$xmlDoc.Save("${file}.result")
