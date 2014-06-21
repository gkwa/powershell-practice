<#

http://blogs.technet.com/b/heyscriptingguy/archive/2014/04/25/use-powershell-to-find-operating-system-version.aspx
http://stackoverflow.com/questions/7330187/how-to-find-windows-version-from-powershell-command-line

#>

(Get-WmiObject -class Win32_OperatingSystem).Caption
[System.Environment]::OSVersion.Version

# http://blogs.technet.com/b/heyscriptingguy/archive/2014/04/25/use-powershell-to-find-operating-system-version.aspx
(Get-CimInstance Win32_OperatingSystem).version
