<#

Usage: ./diff_apache_conf.ps1

#>


$urls = @(
    's3://installer-bin.streambox.com/httpd-2.4.7-win32-VC11.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.7-win64-VC11.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.9-win32-VC11.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.9-win32-VC9.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.9-win64-VC11.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.9-win64-VC9.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.10-win32-VC11.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.10-win32-VC9.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.10-win64-VC11.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.12-win32-VC11.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.12-win32-VC14.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.12-win32-VC9.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.12-win64-VC11.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.12-win64-VC14.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.23-win32-VC14.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.23-win64-VC14.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.25-win32-VC14.zip'
    ,'s3://installer-bin.streambox.com/httpd-2.4.25-win64-VC14.zip'
)

$bn = @()
foreach ($url in $urls) {

    $filename = Split-Path -Leaf $url
    $filename -Match '-((\d+\.)?(\d+\.)?(\*|\d+))-' | Out-Null
    $apache_version = [Version]$matches[1]

    $o = New-Object PSObject -Property @{
        basename = [io.path]::GetFileNameWithoutExtension($filename)
        version = $apache_version
        filename = $filename
        url = $url
    }
    $bn += $o

    if(!(test-path $basename)) {
        if(!(test-path $filename)) {
            aws s3 cp --region us-east-1 $url .
        }
        &7z x -y -o"$basename" $filename
    }
}
$bn = $bn | Sort-Object version

$tmp = 'tmp'
$cdir=$pwd

if(test-path $cdir/$tmp){
    Remove-Item -Recurse -Force $cdir/$tmp
}

mkdir -Force $cdir/$tmp >$null
cd $cdir/$tmp
git init >$null
cd $cdir

foreach ($obj in $bn) {
    $abspath = "{0}/{1}/Apache*/conf" -f $cdir, $obj.basename
    $conf = Get-ChildItem $abspath -ea 0 | Select-Object -Last 1 | Select-Object -exp fullname
    robocopy /mir $conf $cdir/$tmp/conf
    cd $cdir/$tmp
    git add -A conf
    git commit -am ("Add {0} from {1}" -f $obj.version, $obj.basename)
}
cd $cdir
