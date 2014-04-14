clean:
	$(MAKE) -C add_paths_common_binaries clean
	$(MAKE) -C call_system_command clean
	$(MAKE) -C clean_path clean
	$(MAKE) -C parse-xml-with-funky-namespaces clean
	$(MAKE) -C ps_update_path_immediately clean
	$(MAKE) -C update_xml clean
	$(MAKE) -C ini_manip clean
