$regex='^(.*)\s+pid: (\d+)\s+type: ([^ ]+)\s+([A-Fa-f0-9]+): (.*)'

gc handle-output.txt |
  Select-String $regex -AllMatches |
  Foreach-Object { $_.Matches } |
  Foreach-Object {
	  $pname=$_.Groups[1].Value.Trim()
	  $_pid=$_.Groups[2].Value.Trim()
	  $message = "process {0} has handle open on {1}, will kill process {2}" `
		-f $_.Groups[1].Value.Trim(), $_.Groups[5].Value, $_pid
	  "taskkill /f /pid $_pid"
  }
