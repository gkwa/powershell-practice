function remove_dups([string]$path)
{
    $ph = @{};
    $pa = @();
    $path.Split(";") | ForEach {
	$_ = $_.TrimEnd('\')
#	Write-Host "$_";
	if(!$ph.ContainsKey("$_"))
	{
	    $ph.Add("$_",1);
	    $pa = $pa + "$_";
	}
    }

    $cp = $pa -join ';'
    return $cp;
}

# System path
$environmentRegistryKey = 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment';
$oldPath = (Get-ItemProperty -Path $environmentRegistryKey -Name PATH).Path;
$newPath = remove_dups($oldPath);

Set-ItemProperty -Path $environmentRegistryKey -Name PATH -Value $newPath



# User path
$environmentRegistryKey = 'Registry::HKEY_CURRENT_USER\Environment'
$oldPath = (Get-ItemProperty -Path $environmentRegistryKey -Name PATH).Path;
$newPath = remove_dups($oldPath);

Set-ItemProperty -Path $environmentRegistryKey -Name PATH -Value $newPath
