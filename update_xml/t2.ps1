####################################################################################################
# Test
####################################################################################################

$file = 'ts.xml.tmp'
$x = [xml] (Get-Content $file)
$x.SelectNodes("//step") |
  Where-Object { $_.name -eq 'Windows Update (Pre-Application Installation)' } |
  ForEach-Object { $_.disable = 'false' }
$x.Save('ts.xml.tmp')


####################################################################################################
# Test
####################################################################################################

<#
http://www.deployvista.com/Blog/JohanArwidmark/tabid/78/EntryID/132/language/en-US/Default.aspx

powershell Get-Content Where-Object
powershell Get-Content Where-Object value innertext

#>

$file = 'ts.xml.tmp'
$x = [xml] (Get-Content $file)
$y = $x.SelectNodes("//step") | Where-Object { $_.type -eq 'BDD_InjectDrivers' -and $_.name -eq 'Inject Drivers'}
$y.SelectNodes("//variable") | Where-Object { $_.name -eq 'DriverSelectionProfile' } | ForEach-Object { $_.InnerText = 'Nothing' }
$y.SelectNodes("//variable") | Where-Object { $_.name -eq 'DriverInjectionMode' } | ForEach-Object { $_.InnerText = 'AUTO' }
$x.Save('ts.xml.tmp')
