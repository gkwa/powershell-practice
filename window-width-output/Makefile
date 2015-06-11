PS_SW =
PS_SW += -version 4
PS_SW += -inputformat none
PS_SW += -executionpolicy bypass
PS_SW += -noprofile
PS_SW += -noninteractive

t4:
	bash -o pipefail -c 'powershell $(PS_SW) -file t4.ps1 | tee output.txt'

t3:
	bash -o pipefail -c 'powershell $(PS_SW) -file t3.ps1 | tee output.txt'

t2:
	bash -o pipefail -c 'powershell $(PS_SW) -file t2.ps1 | tee output.txt'

t1:
	bash -o pipefail -c 'powershell $(PS_SW) -file t.ps1 | tee output.txt'

clean:
	rm -f output.txt
