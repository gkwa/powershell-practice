<#

http://social.technet.microsoft.com/Forums/windowsserver/en-US/edb9f3c3-5e59-49b6-ad2c-ded2140e0d0e/remove-lines-having-a-word?forum=winserverpowershell

#>

# try regular expression
$content = Get-Content test.txt.tmp | Where-Object {$_ -notmatch "^?ine 2"}
$content | Set-Content test.txt.tmp -Force
