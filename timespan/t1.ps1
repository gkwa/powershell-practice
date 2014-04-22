$ts = new-timespan -minutes 100
"Elapsed Time: {0}" -f $(if($ts.hours -lt 1){"{0} minutes" -f $ts.minutes}else{"{0} hours, {1} minutes" -f $ts.hours, $ts.minutes})

$ts = new-timespan -minutes 10
"Elapsed Time: {0}" -f $(if($ts.hours -lt 1){"{0} minutes" -f $ts.minutes}else{"{0} hours, {1} minutes" -f $ts.hours, $ts.minutes})

$ts = new-timespan -minutes 100.1
"Elapsed Time: {0}" -f $(if($ts.hours -lt 1){"{0} minutes" -f $ts.minutes}else{"{0} hours, {1} minutes" -f $ts.hours, $ts.minutes})

sv startDTM -value (Get-Date) -option constant
start-sleep -s 1
$ts = new-timespan -minutes $(((Get-Date)-$startDTM).TotalMinutes)
"Elapsed Time: {0}" -f $(if($ts.hours -lt 1){"{0} minutes" -f $ts.minutes}else{"{0} hours, {1} minutes" -f $ts.hours, $ts.minutes})
