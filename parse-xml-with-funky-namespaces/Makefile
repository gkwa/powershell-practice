MAKEFLAGS += --warn-undefined-variables

PS_SW  =
PS_SW += -Version 2
PS_SW += -inputformat none
PS_SW += -ExecutionPolicy bypass

TIDY_SW =
TIDY_SW += --force-output true
TIDY_SW += --tidy-mark no
TIDY_SW += --doctype strict
TIDY_SW += --indent-attributes true
TIDY_SW += --vertical-space true
TIDY_SW += -q
TIDY_SW += -xml
TIDY_SW += -i
TIDY_SW += -wrap 60000
TIDY_SW += -c
TIDY_SW += -modify


QUIET_TIDY =
ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
	QUIET_TIDY = @echo '   ' TIDY $@;
	export V
endif
endif

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
