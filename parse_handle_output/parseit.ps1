$regex='^(.*)\s+pid: (\d+)\s+type: ([^ ]+)\s+([A-Fa-f0-9]+): (.*)'

function hasOpenHandle($vmname, $handle_out)
{
	foreach( $line in $handle_out ) {
		$line | Select-String $regex -AllMatches |
		  Foreach-Object { $_.Matches } |
		  Foreach-Object {
			  $pname=$_.Groups[1].Value.Trim()
			  $_pid=$_.Groups[2].Value.Trim()
		  }
		# dont report handle open if handle.exe has open handle
		if($pname -notmatch 'handle(64)?.exe') {
			return $true
		}
	}
	return $false
}

function listHandles($vmname, $handle_out)
{
	foreach( $line in $handle_out ) {
		$line | Select-String $regex -AllMatches |
		  Foreach-Object { $_.Matches } |
		  Foreach-Object {
			  $pname=$_.Groups[1].Value.Trim()
			  $_pid=$_.Groups[2].Value.Trim()
			  $fpath=$_.Groups[5].Value.Trim()
			  "{0} {1} {2} {3}" -f $_pid, [System.IO.Path]::GetExtension($fpath), $pname, $fpath
			  "taskkill /F /pid $_pid"
		  }
	}
}

$vmname='eval-win8x64-enterprise'

# $handle_out = handle $vmname
# $handle_out = gc handle-output.txt
$handle_out = handle $vmname

hasOpenHandle $vmname $handle_out
listHandles $vmname $handle_out
