. '.\IniFile Functions 1.0.ps1'

$CStext = @"
[Settings]
Priority = SetModelAlias, SetMakeAlias, Default
Properties = MyCustomProperty, ModelAlias, MakeAlias

[SetModelAlias]
UserExit = ModelAliasExit.vbs
ModelAlias = #SetModelAlias()#

[SetMakeAlias]
UserExit = ModelAliasExit.vbs
MakeAlias = #SetMakeAlias()#

[Default]
_SMSTSOrgName = $SMSTSOrgName
_SMSTSPackageName = $SMSTSPackageName
SkipBDDWelcome = YES
OSInstall = YES
SkipAdminPassword = YES
SkipBitLocker = YES
SkipDomainMembership = YES
SkipLocaleSelection = YES
SkipRoles = YES
SkipSummary = YES
SkipUserData = YES
SkipFinalSummary = YES
FinishAction = REBOOT
SkipApplications = YES

SkipComputerName = YES
OSDComputerName = SBX#Mid(oStrings.GenerateRandomGUID,2,7)#
; OSDComputerName = LOC-VM-#Right(Replace(Replace(oEnvironment.Item("SerialNumber")," ",""),"-",""),8)#
; OSDComputerName = SBX#Right(Replace(Replace(oEnvironment.Item("SerialNumber")," ",""),"-",""),8)#

SkipTaskSequence = YES
TaskSequenceID = WS7P_INSTALL

SkipProductKey = YES
ProductKey = FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4
; ProductKey = 86G2X-DGTJQ-8X68W-HFJQ2-8MPG2
; http://technet.microsoft.com/en-us/library/ff793421.aspx

SkipComputerBackup = NO
SkipCapture = NO
DoCapture = YES
ComputerBackupLocation = NETWORK
BackupShare = $uncshare
BackupDir = Captures
BackupFile = #"WS7P_" & DatePart("yyyy",Now) & "-" & Right("0" & DatePart("m",Now), 2) & "-" & Right("0" & DatePart("d",Now), 2) & "-" & Right("0" & DatePart("h",Now), 2) & Right("0" & DatePart("n",Now), 2) & ".wim"#

SkipTimeZone = YES
TimeZoneName = GMT Standard Time

; Domain Join Configuration
JoinDomain = $UserDomain
DomainAdmin = $DomainAdmin
DomainAdminDomain = $DomainAdminDomain
DomainAdminPassword = $DomainAdminPassword

; Logging and Monitoring
SLShare = %DEPLOYROOT%\Logs\%COMPUTERNAME%
SLShareDynamicLogging = %DEPLOYROOT%\Logs\%COMPUTERNAME%
EventService = http://${MYIP}:9800

; Hide Windows Shell during deployment
HideShell = YES
; WSUSServer = $WSUSServer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; List of windows updates to exclude
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; EXCLUDED WSUS UPDATES for Windows 7

; Windows udpate process seems to stop at update KB2847077, so try disabling it.
WUMU_ExcludeKB001 = 2847077

; Microsoft Bing Bar
WUMU_ExcludeKB002 = 2673774

; IE9
WUMU_ExcludeKB003 = 982861

; IE10
WUMU_ExcludeKB004 = 2718695

; ;Microsoft Silverlight (KB2636927)
; WUMU_ExcludeKB002 = 2636927

; Windows Internet Explorer 9 for Windows 7 for x64-based Systems (KB982861)
WUMU_ExcludeKB005 = 982861

; ;Windows Internet Explorer 10 for Windows 7 for x64-based Systems (KB2718695)
WUMU_ExcludeKB006 = 2718695

; Bing Desktop (KB2694771)
WUMU_ExcludeKB007 = 2694771

; ; EXCLUDED WSUS UPDATES for Windows 8/8.1
; ; Microsoft Silverlight (KB2668562)
; WUMU_ExcludeKB006 = 2668562
; ; Microsoft Browser Choice Screen Update for EEA Users of Windows 8 for x64-based Systems (KB976002)
; WUMU_ExcludeKB007 = 976002
; ; Update for Internet Explorer Flash Player for Windows 8 for x64-based Systems (KB2824670)
; WUMU_ExcludeKB008 = 2824670
"@


$c1 = "cs1.ini"
$c2 = "cs2.ini"

Set-Content -Path $c1 -value "$CSText"
Set-Content -Path $c2 -value "$CSText"

$text = Get-IniSection($c2)

$t2 = Get-IniValue $c2 "DEFAULT" "DoCapture"
Write-Output $t2

$t3 = Get-IniValue $c2 'Settings' 'BackupFile'
Write-Output ("----------`r`n{0}`r`n----------" -f $t3)

Set-IniValue $c2 "DEFAULT" 'DoCapture' 'NO'
Set-IniValue $c2 "DEFAULT" 'SKIPCAPTURE' 'YES'
