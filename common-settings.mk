MAKEFLAGS += --warn-undefined-variables

PS_SW  =
PS_SW += -version 2
PS_SW += -inputformat none
PS_SW += -executionpolicy bypass

TIDY_SW =
TIDY_SW += --force-output true
TIDY_SW += --tidy-mark no
TIDY_SW += --doctype strict
TIDY_SW += --indent-attributes true
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
