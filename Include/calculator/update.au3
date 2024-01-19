#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Mateo Cedillo

 Script Function:
	Updater.au3 wrapper

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _perform_update
; Description ...: Performs an update for Universal Calculator.
; Syntax ........: _perform_update($sJson, $sRepo[, $sUpdaterDest = @ScriptDir & "\updater.exe"])
; Parameters ....: $sJson               - The json input related to the release API in the GitHub repo.
;                  $sRepo               - The URL of the GitHub repo.
;                  $sUpdaterDest        - [optional] The path to download the updater for the program. Default is @ScriptDir & "\updater.exe".
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _perform_update($sJson, $sRepo, $sUpdaterDest = @ScriptDir & "\updater.exe")
	If Not IsString($sRepo) Then Return SetError(1, 0, "")
	$sRepo = StringReplace($sRepo, "://", "...")
	$sRepo = StringReplace($sRepo, "/", ".")
	$sRepo = StringReplace($sRepo, "-", ".")
	$aRegex = StringRegExp($sJson, $sRepo & '.releases.download.v\d\.\d+[a-zA-Z]?\d*.updater.exe', 3)
	If @error Then Return SetError(2, 0, "")
	$sLastURL = $aRegex[0]
	$hInet = InetGet($sLastURL, $sUpdaterDest, 1, 0)
	If Not FileExists($sUpdaterDest) Then Return SetError(3, 0, "")
	Return True
EndFunc   ;==>_perform_update
; #FUNCTION# ====================================================================================================================
; Name ..........: _DoUpdate
; Description ...: Runs the prebiously downloaded updated with _perform_update.
; Syntax ........: _DoUpdate($sExecutable, $sURL, $sDest[, $sUpdaterDest = @ScriptDir & "\updater.exe"])
; Parameters ....: $sExecutable         - The current executable.
;                  $sURL                - The direct URL to download update files.
;                  $sDest               - Path to extract updated files.
;                  $sUpdaterDest        - [optional] The path of updater.exe prebiously downloaded. Default is @ScriptDir & "\updater.exe".
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _DoUpdate($sExecutable, $sURL, $sDest, $sUpdaterDest = @ScriptDir & "\updater.exe")
	If Not FileExists($sUpdaterDest) Then Return SetError(1, 0, "")
	Return Run($sUpdaterDest & ' "' & $sExecutable & '" "' & $sURL & '" "' & $sDest & '"')
EndFunc   ;==>_DoUpdate
