Param
(
    [string]$shortname = $(throw "-shortname is required.")
)

$file = "Applications.xml"
$xmlFile = $file
[xml]$xml = Get-Content $xmlFile

($xml.applications.application | where { $_.ShortName -match "${shortname}" }).guid
