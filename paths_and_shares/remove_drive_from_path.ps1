split-path -parent $MyInvocation.MyCommand.Definition

split-path $MyInvocation.MyCommand.Definition

split-path $MyInvocation.MyCommand.Definition -qualifier

split-path $MyInvocation.MyCommand.Definition -noqualifier

$p = $MyInvocation.MyCommand.Definition
([io.fileinfo]$p).basename