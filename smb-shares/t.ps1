# http://technet.microsoft.com/en-us/library/jj635722.aspx

if(!(test-path "c:\windows\temp\t"))
{
    new-item "c:\windows\temp\t" -type directory
}

New-SmbShare -Name t -Path "c:\windows\temp\t"