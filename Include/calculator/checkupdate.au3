; check update:
#include "globals.au3"
#include "..\updater.au3"
#include "update.au3"
;#include "UI.au3"
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _calc_check_update
; Description ...: Check for updates through Universal Calculator repo.
; Syntax ........: _calc_check_update([$bSilent = False])
; Parameters ....: $bSilent             - [optional] a boolean value that indicates sylent mode. Default is False (no displaying messages, but returning states instead).
; Return values .: None
; Author ........: Mateo Cedillo
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
		$iDonate = MSGBox(4, Translate($sLang, "Please support us"), translate($sLang, "Due to the effort on this project, we appreciate a donation from you. At least few pennies or hugs makes a big difference. Do you want to do it?"))
		if $iDonate == 6 then run_browser($sDonationUrl)
		_perform_Update($sJson, "https://github.com/rmcpantoja/Universal-calculator")
		If @error Then
			Return SetError(2, 0, "")
		EndIf
		_DoUpdate( _
				@ScriptFullPath, _
				"https://github.com/rmcpantoja/Universal-calculator/releases/download/" & $sVersionGot & "/universal_calculator.zip", _
				@ScriptDir & "\universal_calculator_update.zip" _
				)
	EndIf
EndFunc   ;==>_calc_check_update
