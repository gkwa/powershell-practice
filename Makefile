clean:
	$(MAKE) -C get-node-value-versus-innertext clean
	$(MAKE) -C make_should_fail_with_exit_ps clean
	$(MAKE) -C env_vars_play clean
	$(MAKE) -C add_paths_common_binaries clean
	$(MAKE) -C call_system_command clean
	$(MAKE) -C clean_path clean
	$(MAKE) -C parse-xml-with-funky-namespaces clean
	$(MAKE) -C ps_update_path_immediately clean
	$(MAKE) -C output clean
	$(MAKE) -C update_xml clean
	$(MAKE) -C ternary clean
	$(MAKE) -C ini_manip clean
	$(MAKE) -C timespan clean
	$(MAKE) -C create_subprocesses clean
	$(MAKE) -C paths_and_shares clean
