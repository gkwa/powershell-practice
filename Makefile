test:
	mkdir -p 'c:\windows\temp\test'
	powershell -ExecutionPolicy unrestricted -file env-path-permanently.ps1 'c:\windows\temp\test' true
