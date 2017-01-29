$regex='^(.*)\s+pid: (\d+)\s+type: ([^ ]+)\s+([A-Fa-f0-9]+): (.*)'

function hasOpenHandle( $vmname )
{
#	gc handle-output.txt |
	handle $vmname |
	  Select-String $regex -AllMatches |
	  Foreach-Object { $_.Matches } |
	  Foreach-Object {
		  $pname=$_.Groups[1].Value.Trim()
		  $_pid=$_.Groups[2].Value.Trim()

		  # dont report handle open if handle.exe has open handle
		  if($pname -notmatch 'handle.exe') {
			  return $true
		  }
	  }
	return $false
}

gc handle-output.txt |
  Select-String $regex -AllMatches |
  Foreach-Object { $_.Matches } |
  Foreach-Object {
	  $pname=$_.Groups[1].Value.Trim()
	  $_pid=$_.Groups[2].Value.Trim()
	  $message = "process {0} has handle open on {1}, will kill process {2}" `
		-f $_.Groups[1].Value.Trim(), $_.Groups[5].Value, $_pid
	  "taskkill /f /pid $_pid # $message"
  }

$vmname='eval-win8x64-enterprise'
if(hasOpenHandle $vmname) {
	"handle to $vmname is open"
}
