<#

https://goo.gl/f9Y2xx
http://goo.gl/EwUTBr

Note: The Window Size cannot be larger than the Buffer Size, so the
Buffer Size’s Width must be increased prior to increasing the Window
Size’s Width.
http://goo.gl/6nTAAg

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