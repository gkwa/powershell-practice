include ../common-settings.mk

get_guid:
	$(QUIET_PS)$(PS) $(PS_SW) -file get-guid-for-shortname.ps1 -shortname "Customize Profile"

an7: add_node7
add_node7:
	$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml
	$(QUIET_PS)$(PS) $(PS_SW) -file add-node7.ps1
	-$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml.result
	-diff -uw -U5 Unattend.xml Unattend.xml.result

an6: add_node6
add_node6:
	$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml
	$(QUIET_PS)$(PS) $(PS_SW) -file add-node6.ps1
	-$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml.result
	-diff -uw -U10 Unattend.xml Unattend.xml.result

an4: add_node4
add_node4:
	$(QUIET_PS)$(PS) $(PS_SW) -file add-node4.ps1

ace2: add_child_element2
add_child_element2:
	$(QUIET_PS)$(PS) $(PS_SW) -file add-child-element2.ps1

ace: add_child_element
add_child_element:
	$(QUIET_PS)$(PS) $(PS_SW) -file add-child-element.ps1

an3: add_node3
add_node3:
	$(QUIET_PS)$(PS) $(PS_SW) -file add-node3.ps1

an2: add_node2
add_node2:
	$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml
	$(QUIET_PS)$(PS) $(PS_SW) -file add-node2.ps1
	-$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml.result
	-diff -uw -U10 Unattend.xml Unattend.xml.result

an: add_node
add_node:
	$(QUIET_TIDY)$(TIDY) $(TIDY_SW) ts.xml
	$(QUIET_PS)$(PS) $(PS_SW) -file add-node.ps1
	-$(QUIET_TIDY)$(TIDY) $(TIDY_SW) ts.xml.result
	-diff -uw ts.xml ts.xml.result

tr: test_remove_node
test_remove_node:
	$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml
	$(QUIET_PS)$(PS) $(PS_SW) -file remove-node.ps1
	-$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml.result
	-diff -uw Unattend.xml Unattend.xml.result

ts: test_select_node
test_select_node:
	$(QUIET_TIDY)$(TIDY) $(TIDY_SW) Unattend.xml
	$(QUIET_PS)$(PS) $(PS_SW) -file select-node.ps1

clean:
	rm -f Unattend.xml.result
	rm -f ts.xml.result
