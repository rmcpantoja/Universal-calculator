; check update:
#include "globals.au3"
#include "..\updater.au3"
#include "update.au3"
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _calc_check_update
; Description ...:
; Syntax ........: _calc_check_update([$bSilent = False])
; Parameters ....: $bSilent             - [optional] a boolean value. Default is False.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _calc_check_update($bSilent = False)
	$aUpdateHandler = checkupdate($sProgramVer, "rmcpantoja/universal-calculator", $bSilent)
	If @error Then
		ConsoleWrite("Warning: check update receibed an error. Code: " & @error)
		Return SetError(1, 0, "")
	EndIf
	$bUpdate = $aUpdateHandler[0]
	$sVersionGot = $aUpdateHandler[1]
	$sJson = $aUpdateHandler[2]
	If $bUpdate Then
		_perform_Update($sJson, "https://github.com/rmcpantoja/Universal-calculator")
		If @error Then
			MsgBox(16, "Error", "Couldn't download files for this update.")
			Return SetError(2, 0, "")
		EndIf
		_DoUpdate(@ScriptFullPath, "https://github.com/rmcpantoja/Universal-calculator/releases/download/" & $sVersionGot & "/universal_calculator.zip", @ScriptDir & "\universal_calculator_update.zip")
	EndIf
EndFunc   ;==>_calc_check_update
