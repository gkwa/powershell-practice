t4:
# http://unix.stackexchange.com/questions/25898/how-can-i-pipe-output-to-another-process-but-retain-the-error-state-of-the-firs
	@echo make error out on this next powershell command
	bash -o pipefail -c 'powershell -inputformat none -executionpolicy bypass -file t1.ps1 | tee t1_out.txt'
	@echo after

t3:
	@echo make error out on this next powershell command
	powershell -inputformat none -executionpolicy bypass -file t1.ps1 | tee t1_out.txt
	@echo after

t2:
	@echo make error out on this next powershell command
	powershell -inputformat none -executionpolicy bypass -file t1.ps1 2>&1 | tee t1_out.txt
	@echo after

t1:
	@echo make error out on this next powershell command
	powershell -inputformat none -executionpolicy bypass -file t1.ps1
	@echo after

clean:
	rm -f t1_out.txt
