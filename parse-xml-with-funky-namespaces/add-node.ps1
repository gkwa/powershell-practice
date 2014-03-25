<#

Starting with this:
SMS_TaskSequence_RunCommandLineAction
BDD_InjectDrivers

create this:
SMS_TaskSequence_RunCommandLineAction
SMS_TaskSequence_SetVariableAction
BDD_InjectDrivers

so, we're adding SMS_TaskSequence_SetVariableAction in between SMS_TaskSequence_RunCommandLineAction and BDD_InjectDrivers.




http://weblogs.asp.net/sonukapoor/archive/2004/05/11/129934.aspx

Get-Content  SelectSingleNode add node after

powershell get_DocumentElement

powershell importnode
powershell importnode InsertAfter SelectSingleNode
importnode InsertAfter SelectSingleNode
powershell InsertAfter SelectSingleNode

http://social.technet.microsoft.com/Forums/windowsserver/en-US/7341e2a0-0f84-4cb6-92cd-9765c1c4049b/xml-programming-question?forum=winserverpowershell

    <step type="SMS_TaskSequence_RunCommandLineAction" name="Enable BitLocker (Offline)" description="" disable="false" continueOnError="true" startIn="" successCodeList="0 3010" runIn="WinPEandFullOS">
      <action>cscript.exe "%SCRIPTROOT%\ZTIBDE.wsf"</action>
      <defaultVarList>
        <variable name="RunAsUser" property="RunAsUser">false</variable>
        <variable name="SMSTSRunCommandLineUserName" property="SMSTSRunCommandLineUserName"></variable>
        <variable name="SMSTSRunCommandLineUserPassword" property="SMSTSRunCommandLineUserPassword"></variable>
        <variable name="LoadProfile" property="LoadProfile">false</variable>
      </defaultVarList>
    </step>

    <step type="SMS_TaskSequence_SetVariableAction" name="Set DriverGroup001" description="" disable="false" continueOnError="false" successCodeList="0 3010">
      <defaultVarList>
        <variable name="VariableName" property="VariableName">DriverGroup001</variable>
        <variable name="VariableValue" property="VariableValue">Windows 7 x86\%MakeAlias%\%ModelAlias%</variable>
      </defaultVarList>
      <action>cscript.exe "%SCRIPTROOT%\ZTISetVariable.wsf"</action>
    </step>

    <step type="BDD_InjectDrivers" name="Inject Drivers" description="" disable="false" continueOnError="false" runIn="WinPEandFullOS" successCodeList="0 3010">
      <defaultVarList>
        <variable name="DriverSelectionProfile" property="DriverSelectionProfile">All Drivers</variable>
        <variable name="DriverInjectionMode" property="DriverInjectionMode">AUTO</variable>
      </defaultVarList>
      <action>cscript.exe "%SCRIPTROOT%\ZTIDrivers.wsf"</action>
    </step>

#>

$file = "ts.xml"
$xmlFile = $file
[xml]$xmlDoc = Get-Content $xmlFile
[System.Xml.XmlElement]$stepA = $xmlDoc.SelectSingleNode("//step[@name='Enable BitLocker (Offline)']")

$stepB_xml = [xml]@"
    <step type="SMS_TaskSequence_SetVariableAction" name="Set DriverGroup001" description="" disable="false" continueOnError="false" successCodeList="0 3010">
      <defaultVarList>
        <variable name="VariableName" property="VariableName">DriverGroup001</variable>
        <variable name="VariableValue" property="VariableValue">Windows 7 x86\%MakeAlias%\%ModelAlias%</variable>
      </defaultVarList>
      <action>cscript.exe "%SCRIPTROOT%\ZTISetVariable.wsf"</action>
    </step>
"@

[System.Xml.XmlElement]$elem = $stepB_xml.get_DocumentElement()
[System.Xml.XmlNode]$stepB = $xmlDoc.ImportNode($elem, $True)
[Void]$stepA.ParentNode.InsertAfter($stepB, $stepA)
$xmlDoc.Save("${file}.result")
