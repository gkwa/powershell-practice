include ../common-settings.mk

t4:
# http://unix.stackexchange.com/questions/25898/how-can-i-pipe-output-to-another-process-but-retain-the-error-state-of-the-firs
	@echo make error out on this next powershell command
	bash -o pipefail -c 'powershell $(PS_SW) -file t1.ps1 | tee t1_out.txt'
	@echo after

t3:
	@echo this is incorrect, since pipe hides powershell nonzero exit code
	powershell $(PS_SW) -file t1.ps1 | tee t1_out.txt
	@echo after

t2:
	@echo this is incorrect, since pipe hides powershell nonzero exit code
	powershell $(PS_SW) -file t1.ps1 2>&1 | tee t1_out.txt
	@echo after

t1:
	@echo this is correct.  We will never see "after" since there is no pipe to mask the failing powershell script
	powershell $(PS_SW) -file t1.ps1
	@echo after

clean:
	rm -f t1_out.txt
