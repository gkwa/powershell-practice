<#

https://goo.gl/f9Y2xx
http://goo.gl/EwUTBr

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