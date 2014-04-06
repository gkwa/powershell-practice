include ../common-settings.mk

an4: add_node4
add_node4:
	powershell $(PS_SW) -file add-node4.ps1

ace2: add_child_element2
add_child_element2:
	powershell $(PS_SW) -file add-child-element2.ps1

ace: add_child_element
add_child_element:
	powershell $(PS_SW) -file add-child-element.ps1

an3: add_node3
add_node3:
	powershell $(PS_SW) -file add-node3.ps1

an2: add_node2
add_node2:
	$(QUIET_TIDY)tidy $(TIDY_SW) Unattend.xml
	powershell $(PS_SW) -file add-node2.ps1
	-$(QUIET_TIDY)tidy $(TIDY_SW) Unattend.xml.result
	-diff -uw -U10 Unattend.xml Unattend.xml.result

an: add_node
add_node:
	$(QUIET_TIDY)tidy $(TIDY_SW) ts.xml
	powershell $(PS_SW) -file add-node.ps1
	-$(QUIET_TIDY)tidy $(TIDY_SW) ts.xml.result
	-diff -uw ts.xml ts.xml.result

tr: test_remove_node
test_remove_node:
	$(QUIET_TIDY)tidy $(TIDY_SW) Unattend.xml
	powershell $(PS_SW) -file remove-node.ps1
	-$(QUIET_TIDY)tidy $(TIDY_SW) Unattend.xml.result
	-diff -uw Unattend.xml Unattend.xml.result

ts: test_select_node
test_select_node:
	$(QUIET_TIDY)tidy $(TIDY_SW) Unattend.xml
	powershell $(PS_SW) -file select-node.ps1

clean:
	rm -f Unattend.xml.result
	rm -f ts.xml.result
