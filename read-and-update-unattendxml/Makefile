include common-settings.mk

test3:
	$(QUIET_PS)$(PS) $(PS_SW) -file unattended-update.ps1 -u '.\Unattended.xml'

test2:
	$(QUIET_PS)$(PS) $(PS_SW) -file unattended-update.ps1 -unattendedfile '.\Unattended.xml'

list:
	$(QUIET_PS)$(PS) $(PS_SW) -file unattended-update.ps1 -list

scrape:
	$(QUIET_PS)$(PS) $(PS_SW) -file unattended-update.ps1 -scrape

ie:
	sh find_IE_stuff.sh

clean:
	rm -f [0-9][0-9][0-9][0-9][0-9]*.txt
	rm -f wget.list

