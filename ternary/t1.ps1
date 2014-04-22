<#
http://blogs.msdn.com/b/powershell/archive/2006/12/29/dyi-ternary-operator.aspx
#>

#. '.\Invoke-Ternary.ps1'

$quantity=1
$price=2

$total = ($quantity * $price ) * ({$quantity -le 10} ? {.9} : {.75})
$total

$total = ($quantity * $price ) * (?:  {$quantity -le 10} {.9} {.75})
$total