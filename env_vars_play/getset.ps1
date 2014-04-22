"Only visible to current environment:"
$Env:TestVariable = "This is a test environment variable."
'$Env:TestVariable:{0}' -f $Env:TestVariable
"`r"
@"
process-level environment variables. To create more permanent
environment variables (i.e., user-level or machine-level) you need to
use the .NET Framework and the SetEnvironmentVariable method.
"@
[Environment]::SetEnvironmentVariable("TestVariable1", "Test value.", "User")
'Even after setting via .NET, I cant get the value using $Env:TestVariable1, I still need .NET to get the value in _this_ session:'
'$Env:TestVariable1:{0}' -f $Env:TestVariable1
'[Environment]::GetEnvironmentVariable("TestVariable1","User"):{0}' -f [Environment]::GetEnvironmentVariable("TestVariable1","User")
