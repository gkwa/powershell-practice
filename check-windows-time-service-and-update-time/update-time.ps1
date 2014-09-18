<#
http://technet.microsoft.com/en-us/library/ee176858.aspx

#>

$w32time_status = get-service w32time | Where-Object {$_.status -eq "running"}
if($w32time_status){
    "already running"
} else {
    start-service w32time
    $w32time_status = get-service w32time | Where-Object {$_.status -eq "running"}
    if($w32time_status)
    {
	"w32 time running now"
    }
}

set-location 'C:\Windows\System32'
get-location
& w32tm.exe /query /status /verbose

set-location 'c:\Windows\SysWOW64'
get-location
& w32tm.exe /query /status /verbose

