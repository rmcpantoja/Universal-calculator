; check update:
#include "globals.au3"
#include "..\updater.au3"
#include "update.au3"
#include-once

func _calc_check_update($bSilent = False)
		$aUpdateHandler = checkupdate($sProgramVer, "rmcpantoja/universal-calculator", $bSilent)
		if @error then
			ConsoleWrite("Warning: check update receibed an error. Code: " & @error)
			Return SetError(1, 0, "")
		EndIf
		$bUpdate = $aUpdateHandler[0]
		$sVersionGot = $aUpdateHandler[1]
		$sJson = $aUpdateHandler[2]
		if $bUpdate then
			_perform_Update($sJson, "https://github.com/rmcpantoja/Universal-calculator")
			if @error then
				MsgBox(16, "Error", "Couldn't download files for this update.")
				return SetError(2, 0, "")
			EndIf
			_DoUpdate(@ScriptFullPath, "https://github.com/rmcpantoja/Universal-calculator/releases/download/" &$sVersionGot &"/universal_calculator.zip", @ScriptDir &"\universal_calculator_update.zip")
		EndIf
EndFunc