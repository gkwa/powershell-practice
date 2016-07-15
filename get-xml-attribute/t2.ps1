$xfiles = [xml](gc "files.xml")
$filenodes = $xfiles.SelectNodes("//file")

foreach ($file in $filenodes){
	echo $file.GetAttribute("actl3url")
}
