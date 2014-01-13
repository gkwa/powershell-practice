test:
	powershell -ExecutionPolicy unrestricted -file add_paths.ps1
check:
	cmd /c reg query 'HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | grep ^[[:blank:]]*Path | tr ';' '\n' | cat -n - 
	echo
	cmd /c "reg query hkcu\environment /v Path" | grep ^[[:blank:]]*Path | tr ';' '\n' | cat -n - 
