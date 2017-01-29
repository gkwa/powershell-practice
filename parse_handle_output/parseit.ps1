. .\logger.ps1

$regex='^(.*)\s+pid: (\d+)\s+type: ([^ ]+)\s+([A-Fa-f0-9]+): (.*)'

$ErrorActionPreference = "SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path output.txt -append

gc handle-output.txt |
  Select-String $regex -AllMatches |
  Foreach-Object { $_.Matches } |
  Foreach-Object {
	  $pname=$_.Groups[1].Value.Trim()
	  $_pid=$_.Groups[2].Value.Trim()
	  $message = "process {0} has handle open on {1}, will kill process {2}" `
		-f $_.Groups[1].Value.Trim(), $_.Groups[5].Value, $_pid
	  
	  Write-Log $message "INFO" 
	  "taskkill /f /pid $_pid"
  } >out.txt

Stop-Transcript
