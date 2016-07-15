$xfiles = [xml](gc "files.xml")
$f = $xfiles.files.SelectSingleNode("//file[@shortname='f1']")
$f.GetAttribute("duration")
$f.GetAttribute("actl3url")
