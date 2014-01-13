$paths = (
    "c:\Program Files\Oracle\VirtualBox",
    "c:\cygwin\bin",
    "c:\cygwin64\bin"
);

foreach($p in $paths)
{
    if(Test-Path "$p")
    {
	& ..\ps_update_path_immediately\env-path-permanently.ps1 "$p";
    }
}