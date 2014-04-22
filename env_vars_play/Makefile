include ../common-settings.mk

getset:
	$(QUIET_PS)$(PS) $(PS_SW) -file getset.ps1

check:
	cmd /c set | findstr /i testvariable1

get:
	$(QUIET_PS)$(PS) $(PS_SW) -file get.ps1

clean:
	$(QUIET_PS)$(PS) $(PS_SW) -file clean.ps1

.PHONY: get
.PHONY: getset
.PHONY: clean
