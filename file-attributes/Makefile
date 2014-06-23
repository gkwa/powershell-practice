tfa: test_file_attributes
test_file_attributes:
	touch testFile.txt
	powershell -version 4 -executionpolicy bypass -file test_file_attributes.ps1 -filename testFile.txt

clean:
	rm -f testFile.txt