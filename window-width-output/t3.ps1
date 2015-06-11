<#

http://blogs.technet.com/b/heyscriptingguy/archive/2006/12/04/how-can-i-expand-the-width-of-the-windows-powershell-console.aspx

#>

$pshost = get-host
$pswindow = $pshost.ui.rawui

$newsize = $pswindow.buffersize
$newsize.height = 3000
$newsize.width = 150
$pswindow.buffersize = $newsize

$newsize = $pswindow.windowsize
$newsize.height = 50
$newsize.width = 150
$pswindow.windowsize = $newsize