<#

http://social.technet.microsoft.com/Forums/windowsserver/en-US/edb9f3c3-5e59-49b6-ad2c-ded2140e0d0e/remove-lines-having-a-word?forum=winserverpowershell

#>

# from this i realize notmatch is case INSENSITIVE
$content = Get-Content test.txt.tmp | Where-Object {$_ -notmatch "Line.*"}
$content | Set-Content test.txt.tmp -Force
