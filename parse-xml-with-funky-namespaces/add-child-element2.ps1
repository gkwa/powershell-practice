$xmlstring = @"
<root>
<x>
</x>
<y.z>
<w/>
</y.z>
</root>
"@

[xml]$xml = $xmlstring
$xml.outerxml
$newxml = [xml]@"
<fDenyTSConnections>false</fDenyTSConnections>
"@

$xml.GetType()
$newxml.GetType()

$newNode = $xml.ImportNode($newxml.DocumentElement,$true)
[void]$xml.root['x'].AppendChild($newNode)
$xml.outerxml
