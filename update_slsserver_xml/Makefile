t1:
	powershell -version 1 -inputformat none -executionpolicy bypass -file update_xml_attribute.ps1

test_update_machine:
	scp update_xml_attribute.ps1 livedev3:/c/sls_db
	ssh livedev3 'cd /c/sls_db && powershell -inputformat none -executionpolicy bypass -file update_xml_attribute.ps1 && rm -f update_xml_attribute.ps1 && 	sed -i -e "1s/^\xEF\xBB\xBF//" slsserver.xml'

bom: remove_bom
remove_bom:
	sed -i -e '1s/^\xEF\xBB\xBF//' slsserver.xml

clean:
