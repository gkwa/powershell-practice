PS_SW =
PS_SW += -version 4
PS_SW += -inputformat none
PS_SW += -executionpolicy bypass
PS_SW += -noprofile
PS_SW += -noninteractive

t1:
	bash -o pipefail -c 'powershell $(PS_SW) -file t.ps1 | tee output.txt'

clean:
	rm -f output.txt
