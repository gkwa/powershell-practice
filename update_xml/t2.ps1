$file = 'ts.xml.tmp'
$x = [xml] (Get-Content $file)
$x.SelectNodes("//step") | 
  Where-Object { $_.name -eq 'Windows Update (Pre-Application Installation)' } |
  ForEach-Object { $_.disable = 'false' }
$x.Save('ts.xml.tmp')
