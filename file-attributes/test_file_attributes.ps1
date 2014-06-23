# http://scriptolog.blogspot.com/2007/10/file-attributes-helper-functions.html

<#

http://blogs.technet.com/b/heyscriptingguy/archive/2011/01/27/use-powershell-to-toggle-the-archive-bit-on-files.aspx
http://powershell.com/cs/blogs/ebookv2/archive/2012/03/13/chapter-6-working-with-objects.aspx

powershell System.IO.FileAttributes remove archive
System.IO.FileAttributes "does not contain a method named"
System.IO.FileInfo cast

#>

# [CmdletBinding()]
# Param(
#     [Parameter(Mandatory=$true)]
#     [string]$file
# )

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$filename
)

function Get-FileAttribute{
    param($file,$attribute)
    $val = [System.IO.FileAttributes]$attribute;
    if((gci $file -force).Attributes -band $val -eq $val){$true;} else { $false; }
}

function Set-FileAttribute{
    param($file,$attribute)
    $file =(gci $file -force);
    $file.Attributes = $file.Attributes -bor ([System.IO.FileAttributes]$attribute).value__;
    if($?){$true;} else {$false;}
}

function Clear-FileAttributeOrig{
    param($file,$attribute)
    $file =(gci $file -force);
    $file.Attributes -= ([System.IO.FileAttributes]$attribute).value__;
    if($?){$true;} else {$false;}
}

function Clear-FileAttribute{
    param($file,$attribute)

    # $file =(gci $file -force);
    # $file.Attributes -= ([System.IO.FileAttributes]$attribute).value__;
    # if($?){$true;} else {$false;}

    $file =(gci $file -force);
    If((Get-ItemProperty -Path $file.fullname).attributes -band [System.IO.FileAttributes]$attribute)
    {
	Set-ItemProperty -Path $file.fullname -Name attributes `
	  -Value ((Get-ItemProperty $file.fullname).attributes -BXOR [System.IO.FileAttributes]$attribute)
	(Get-ItemProperty -Path $file.fullname).attributes
    }
}

$ErrorActionPreference = 'stop'
$WarningPreference = 'stop'



# create test file
# $file = new-item -path . -name testFile.txt -type file;

$file = get-item $filename

# Get-ItemProperty -Path $filename | Get-Member -MemberType property

# $file.GetType()

# $file | gm

write-host "`nIs file ReadOnly? " -nonewline
Get-FileAttribute $file.FullName ReadOnly
"attributes: " +(gci $file.FullName -force).attributes;

write-host "`nSet file as ReadOnly. Action succeeded? " -nonewline
Set-FileAttribute $file.fullname ReadOnly
"attributes: " +(gci $file.FullName -force).attributes;

write-host "`nSet file as Hidden. Action succeeded? " -nonewline
Set-FileAttribute $file.FullName Hidden
"attributes: " +(gci $file.FullName -force).attributes;

if(Get-FileAttribute $file.FullName Hidden){
    write-host "`nFile is marked as Hidden"

    if(Clear-FileAttribute $file.FullName Hidden){
        write-host "File is no longer Hidden"
    } else {
        write-host "error clearing hidden attribute"
    }
    "attributes: " +(gci $file.FullName -force).attributes;
}

# delete test file
remove-item .\$filename -force
