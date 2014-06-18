$deployment='ws7p'

Write-Host "Call 1"
$os_index = ([xml](gc "deployments.xml")).deployments.$deployment.os_index.FirstChild.Value
$os_index

Write-Host "Call 2"
$os_index = ([xml](gc "deployments.xml")).deployments.$deployment.os_index
$os_index

$deployment='WS7P'

Write-Host "Call 3"
$os_index = ([xml](gc "deployments.xml")).deployments.$deployment.os_index.FirstChild.Value
$os_index

$deployment='ws7p'

Write-Host "Call 4"
$os_index = ([xml](gc "deployments.xml")).deployments.$deployment.os_index
$os_index

Write-Host "Call 5"
$os_index = ([xml](gc "deployments.xml")).deployments.$deployment.os_index.InnerText
$os_index

Write-Host "Call 6"
(([xml](gc "deployments.xml")).deployments.$deployment.os_index).GetType()

Write-Host "Call 7"
(([xml](gc "deployments.xml")).deployments.$deployment).GetType()

Write-Host "Call 8"
(([xml](gc "deployments.xml")).deployments.$deployment.FirstChild).GetType()

Write-Host "Call 9"
([xml](gc "deployments.xml")).deployments.$deployment.FirstChild.InnerText

Write-Host "Call 10"
(([xml](gc "deployments.xml")).deployments.$deployment.os_index).GetType()

Write-Host "Call 11"
(([xml](gc "deployments.xml")).deployments.$deployment.pssubfolder).GetType()

Write-Host "Call 12"
([xml](gc "deployments.xml")).deployments.$deployment.pssubfolder

Write-Host "Call 13"
([xml](gc "deployments.xml")).deployments.$deployment.wimNameOnFirstImport

$deployment='ws7e'

Write-Host "Call 14"
$os_index = ([xml](gc "deployments.xml")).deployments.$deployment.os_index
$os_index
