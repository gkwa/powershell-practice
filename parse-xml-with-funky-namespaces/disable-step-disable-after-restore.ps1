$file = "ts.xml"
$xml = [xml](Get-Content $file)

$step_restore = @($xml.SelectNodes('//step') | where { $_.name -eq 'Restore User State' })[0]
[void]$step_restore.SetAttribute("disable", "", "true")

$xml.Save("${file}.result")
