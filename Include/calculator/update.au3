#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include-once

func _perform_update($sJson, $sRepo, $sUpdaterDest = @ScriptDir & "\updater.exe")
If not IsString($sRepo) then Return SetError(1, 0, "")
$sRepo = StringReplace($SRepo, "://", "...")
$sRepo = StringReplace($SRepo, "/", ".")
$sRepo = StringReplace($SRepo, "-", ".")
$aRegex = StringRegExp($sJson, $sRepo & '.releases.download.v\d\.\d.updater.exe', 3)
if @error then return SetError(2, 0, "")
$sLastURL = $aRegex[0]
$hInet = InetGet($sLastURL, $sUpdaterDest, 1, 0)
if not FileExists($sUpdaterDest) then Return SetError(3, 0, "")
return True
EndFunc
func _DoUpdate($sExecutable, $sURL, $sDest, $sUpdaterDest = @ScriptDir & "\updater.exe")
if not FileExists($sUpdaterDest) then Return SetError(1, 0, "")
return run($sUpdaterDest & ' "' &$sExecutable & '" "' & $sURL & '" "' & $sDest & '"')
EndFunc