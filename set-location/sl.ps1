if(!(test-path 'scratch'))
{
    $result = mkdir scratch
}
$result = set-location scratch
$loc = get-location
Write-Host $loc

if(!(test-path ".\7za.exe"))
{
    Write-Host "Downloading 7za.exe..."
    (new-object System.Net.WebClient).DownloadFile("http://installer-bin.streambox.com/7za.exe", "scratch\7za.exe")
}
