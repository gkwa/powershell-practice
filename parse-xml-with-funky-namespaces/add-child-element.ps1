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
$w = $xml.root."y.z"["w"]
$abc = $xml.CreateElement("abc")
[void]$w.AppendChild($abc)
$xml.OuterXml