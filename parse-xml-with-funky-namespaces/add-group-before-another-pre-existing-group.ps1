<#

* Add this to WS7E Capture

# Screenshot showing what this does
https://www.flickr.com/photos/taylormonacelli/15073028991/in/set-72157647010290445

# Summary
Add an additional step to deployment that installs windows updates

# Detail
create a new group "Fetch Windows Updates" call it groupFetch
find group "Capture Image" call it groupCapture
add groupFetch as sibling to groupCapture to groupCapture's parent (which is <sequence...>)

  <group expand="true" name="Fetch Windows Updates" description="" disable="false" continueOnError="false">
    <action />
    <step type="BDD_InstallUpdatesOffline" name="Install Updates Offline" description="" disable="false" continueOnError="false" runIn="WinPEandFullOS" successCodeList="0 3010">
      <defaultVarList>
        <variable name="PackageSelectionProfile" property="PackageSelectionProfile"></variable>
      </defaultVarList>
      <action>cscript.exe "%SCRIPTROOT%\ZTIPatches.wsf"</action>
    </step>
  </group>

As in...:

<?xml version="1.0"?>
<sequence version="3.00" name="Sysprep and Capture" description="Syspreps the System for capture and captures an image">
  <group expand="true" name="Fetch Windows Updates" description="" disable="false" continueOnError="false">
    <action />
    <step type="BDD_InstallUpdatesOffline" name="Install Updates Offline" description="" disable="false" continueOnError="false" runIn="WinPEandFullOS" successCodeList="0 3010">
      <defaultVarList>
        <variable name="PackageSelectionProfile" property="PackageSelectionProfile"></variable>
      </defaultVarList>
      <action>cscript.exe "%SCRIPTROOT%\ZTIPatches.wsf"</action>
    </step>
  </group>
  <group name="Capture Image" disable="false" continueOnError="false" expand="true" description="">
    <condition></condition>
    <step type="SMS_TaskSequence_SetVariableAction" name="Set Image Build" description="" disable="false" continueOnError="false" successCodeList="0 3010">
      <defaultVarList>
        <variable name="VariableName" property="VariableName">ImageBuild</variable>
        <variable name="VariableValue" property="VariableValue">%OSCURRENTVERSION%</variable>
      </defaultVarList>
      <action>cscript.exe "%SCRIPTROOT%\ZTISetVariable.wsf"</action>
    </step>
    <step type="SMS_TaskSequence_SetVariableAction" name="Set ImageFlags" description="" disable="false" continueOnError="false" successCodeList="0 3010">

#>

$groupFetchXML = [xml]@"
  <group expand="true" name="Fetch Windows Updates" description="" disable="false" continueOnError="false">
    <action />
    <step type="BDD_InstallUpdatesOffline" name="Install Updates Offline" description="" disable="false" continueOnError="false" runIn="WinPEandFullOS" successCodeList="0 3010">
      <defaultVarList>
        <variable name="PackageSelectionProfile" property="PackageSelectionProfile"></variable>
      </defaultVarList>
      <action>cscript.exe "%SCRIPTROOT%\ZTIPatches.wsf"</action>
    </step>
  </group>
"@

$file="ts2.xml"
[xml]$xmlDoc = Get-Content $file
[System.Xml.XmlElement]$groupCaptureNode = $xmlDoc.SelectSingleNode("//group[@name='Capture Image']")
[System.Xml.XmlElement]$groupFetchElem = $groupFetchXML.get_DocumentElement()
[System.Xml.XmlNode]$groupFetchNode = $xmlDoc.ImportNode($groupFetchElem, $True)
[Void]$groupCaptureNode.ParentNode.InsertBefore($groupFetchNode, $groupCaptureNode)
$xmlDoc.Save("${file}.result")
