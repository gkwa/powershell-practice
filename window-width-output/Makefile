PS_SW =
PS_SW += -version 4
PS_SW += -inputformat none
PS_SW += -executionpolicy bypass
PS_SW += -noprofile
PS_SW += -noninteractive

t1:
	bash -o pipefail -c 'powershell $(PS_SW) -file t.ps1 \
		-trace \
		-skipupdates \
		-virtualbox_drivers_only \
		-skipcatalog \
		-vmname efast \
		-deployment $(DEPLOYMENT_WS7E) -embedded \
		-guestDirRelative $(basename $(ISO_WS7E_FAST)) \
		-autounattend_file AUTOUNATTEND.XML | tee CreateMDTDeploymentShare_trace_$@.txt'

clean:
