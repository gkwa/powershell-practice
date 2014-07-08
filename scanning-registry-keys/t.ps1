<#

Script outputs the following set-itempropery to $outfile

set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007" "*FlowControl" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007\Ndi\savedParams\*FlowControl" "default" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007" "*InterruptModeration" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007\Ndi\savedParams\*InterruptModeration" "default" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007" "ITR" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007\Ndi\savedParams\*InterruptModeration" "default" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0009" "*FlowControl" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0009\Ndi\savedParams\*FlowControl" "default" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0009" "*InterruptModeration" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0009\Ndi\savedParams\*InterruptModeration" "default" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0009" "ITR" 0
set-itemproperty "hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0009\Ndi\savedParams\*InterruptModeration" "default" 0

#>


$script=$MyInvocation.MyCommand.Name
$outfile = (Get-Location).Path + "\${script}_step1.ps1"

if(test-path "$outfile")
{
    remove-item "$outfile"
}

$base = 'hklm:\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}'
foreach($key in Get-ItemProperty "$base\*" -ea SilentlyContinue | ForEach-Object {$_.PSChildName })
{
    # $key is 3 digit number like 007 or 009

    ##############################
    # *FlowControl
    ##############################
    $newDefaultValue=$null
    if(test-path "$base\$key\Ndi\savedParams\*FlowControl\Enum")
    {
	cd "$base\$key\Ndi\savedParams\*FlowControl\Enum"
	Get-Item . |
	  Select-Object -ExpandProperty property |
	  ForEach-Object {
	      $value = (Get-ItemProperty -Path . -Name $_).$_

	      if($value -match "Disabled"){
		  $newDefaultValue=$_
		  "set-itemproperty ""$base\$key"" ""*FlowControl"" $newDefaultValue"  >>"$outfile"
	      }
	  }
    }
    # ...and set the new default-value
    if(-not($newDefaultValue -eq $null))
    {
	if(test-path "$base\$key\Ndi\savedParams\*FlowControl")
	{
	    "set-itemproperty ""$base\$key\Ndi\savedParams\*FlowControl"" ""default"" $newDefaultValue"  >>"$outfile"
	}
    }

    ##############################
    # *InterruptModeration
    ##############################
    $newDefaultValue=$null
    if(test-path "$base\$key\Ndi\savedParams\*InterruptModeration\Enum")
    {
	cd "$base\$key\Ndi\savedParams\*InterruptModeration\Enum"
	Get-Item . |
	  Select-Object -ExpandProperty property |
	  ForEach-Object {
	      $value = (Get-ItemProperty -Path . -Name $_).$_

	      if($value -match "Disabled"){
		  $newDefaultValue=$_
		  "set-itemproperty ""$base\$key"" ""*InterruptModeration"" $newDefaultValue"  >>"$outfile"
	      }
	  }
    }
    # ...and set the new default-value
    if(-not($newDefaultValue -eq $null))
    {
	if(test-path "$base\$key\Ndi\savedParams\*InterruptModeration")
	{
	    "set-itemproperty ""$base\$key\Ndi\savedParams\*InterruptModeration"" ""default"" $newDefaultValue"  >>"$outfile"
	}
    }

    ##############################
    # ITR
    ##############################
    $newDefaultValue=$null
    if(test-path "$base\$key\Ndi\savedParams\ITR\Enum")
    {
	cd "$base\$key\Ndi\savedParams\ITR\Enum"
	Get-Item . |
	  Select-Object -ExpandProperty property |
	  ForEach-Object {
	      $value = (Get-ItemProperty -Path . -Name $_).$_

	      if($value -match "Off"){
		  $newDefaultValue = $_
		  "set-itemproperty ""$base\$key"" ""ITR"" $newDefaultValue" >>"$outfile"
	      }
	  }
    }
    # ...and set the new default-value
    if(-not($newDefaultValue -eq $null))
    {
	if(test-path "$base\$key\Ndi\savedParams\ITR")
	{
	    "set-itemproperty ""$base\$key\Ndi\savedParams\*InterruptModeration"" ""default"" $newDefaultValue"  >>"$outfile"
	}
    }
}
