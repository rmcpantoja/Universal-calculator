#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include-once

Func _perform_update($sJson, $sRepo, $sUpdaterDest = @ScriptDir & "\updater.exe")
	If Not IsString($sRepo) Then Return SetError(1, 0, "")
	$sRepo = StringReplace($sRepo, "://", "...")
	$sRepo = StringReplace($sRepo, "/", ".")
	$sRepo = StringReplace($sRepo, "-", ".")
	$aRegex = StringRegExp($sJson, $sRepo & '.releases.download.v\d\.\d.updater.exe', 3)
	If @error Then Return SetError(2, 0, "")
	$sLastURL = $aRegex[0]
	$hInet = InetGet($sLastURL, $sUpdaterDest, 1, 0)
	If Not FileExists($sUpdaterDest) Then Return SetError(3, 0, "")
	Return True
EndFunc   ;==>_perform_update
Func _DoUpdate($sExecutable, $sURL, $sDest, $sUpdaterDest = @ScriptDir & "\updater.exe")
	If Not FileExists($sUpdaterDest) Then Return SetError(1, 0, "")
	Return Run($sUpdaterDest & ' "' & $sExecutable & '" "' & $sURL & '" "' & $sDest & '"')
EndFunc   ;==>_DoUpdate
