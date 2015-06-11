<#

http://stackoverflow.com/a/1165347/1495086

#>

# Update output buffer size to prevent clipping in Visual Studio output window.
if( $Host -and $Host.UI -and $Host.UI.RawUI ) {
  $rawUI = $Host.UI.RawUI
  $oldSize = $rawUI.BufferSize
  $typeName = $oldSize.GetType( ).FullName
  $newSize = New-Object $typeName (500, $oldSize.Height)
  $rawUI.BufferSize = $newSize
}

$pshost = get-host
$pswindow = $pshost.ui.rawui

$newsize = $pswindow.buffersize
$newsize.height = 3000
$newsize.width = 450
$pswindow.buffersize = $newsize

$Host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size (500, 25)
