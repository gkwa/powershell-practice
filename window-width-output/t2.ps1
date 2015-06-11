$host.ui.rawui
$Host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size (500, 25)

write-verbose "$(get-date)"
write-verbose $($s="";for($i=1;$i -lt 10;$i+=1) {$s+=([string] $i * 9) + " "};$s*5)
