<#

namespace powershell XmlElement get_DocumentElement
System.Xml.XmlElement get_DocumentElement
System.Xml.XmlElement get_DocumentElement
powershell namespace System.Xml.XmlElement get_DocumentElement

XmlElement get_DocumentElement
type System.Xml.XmlDocument. Error "is an undeclared namespace"

powershell wcm get_DocumentElement

powershell get_DocumentElement
XmlElement get_DocumentElement Error "is an undeclared namespace"

Error: "'wcm' is an undeclared namespace

#>


<#

[Administrator@d2:~/pdev/powershell-practice/parse-xml-with-funky-namespaces(master)]$ make
    TIDY find_firstlogoncommands
    POWERSHELL find_firstlogoncommands
xml : Cannot convert value "<SynchronousCommand wcm:action="add">
<Order></Order>
<CommandLine></CommandLine>
<Description></Description>
<RequiresUserInput>false</RequiresUserInput>
</SynchronousCommand>" to type "System.Xml.XmlDocument". Error: "'wcm' is an undeclared namespace. Line 1, position 21."
At C:\cygwin64\home\Administrator\pdev\powershell-practice\parse-xml-with-funky-namespaces\find-firstlogoncommands.ps1:15 char:41
+ [System.Xml.XmlElement]$command = ([xml] <<<< @"
    + CategoryInfo          : NotSpecified: (:) [], RuntimeException
    + FullyQualifiedErrorId : RuntimeException

order:1,count:1
<FirstLogonCommands xmlns="urn:schemas-microsoft-com:unattend">
<SynchronousCommand wcm:action="add" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
<CommandLine>wscript.exe %SystemDrive%\LTIBootstrap.vbs</CommandLine>
<Description>Lite Touch new OS</Description><Order>1</Order>
</SynchronousCommand></FirstLogonCommands>
no firstlogon
    TIDY find_firstlogoncommands
diff -uw -U5 Unattend.xml Unattend.xml.result
[Administrator@d2:~/pdev/powershell-practice/parse-xml-with-funky-namespaces(master)]$

#>

$filename = "Unattend.xml"
[xml]$xml = (gc $filename)

[System.Xml.XmlNamespaceManager]$ns = $xml.NameTable
$ns.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$ns.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")

$settings = $xml.SelectSingleNode('//urn:settings[@pass="oobeSystem"]', $ns)
$comp = $settings.component | where { $_.name -eq 'Microsoft-Windows-Shell-Setup' }

# $firstlogon = $comp.FirstLogonCommands.FirstChild.outerxml
$order = $comp.FirstLogonCommands.SynchronousCommand.Order
# $order = $comp.FirstLogonCommands.LastChild.Order
$count = $comp.FirstLogonCommands.ChildNodes.Count

Write-Host "order:$order,count:$count"

[System.Xml.XmlElement]$command = ([xml]@"
<SynchronousCommand wcm:action="add"
	   xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
<Order></Order>
<CommandLine></CommandLine>
<Description></Description>
<RequiresUserInput>false</RequiresUserInput>
</SynchronousCommand>
"@).get_DocumentElement()

# $comp.FirstLogonCommands.outerxml

[System.Xml.XmlNode]$commandNode = $xml.ImportNode($command, $True)
[System.Xml.XmlElement]$x= $comp.FirstLogonCommands.AppendChild($commandNode)

if(!$fistlogon)
{
    Write-Host "no firstlogon"
}else{
    Write-Host "found"
}

$xml.Save("${filename}.result")
