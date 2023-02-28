; options:
#include <comboConstants.au3>
#include "configs.au3"
#include "globals.au3"
#include <GuiConstantsEx.au3>
#include "language_manager.au3"
#include "..\translator.au3"
;_options()
; #FUNCTION# ====================================================================================================================
; Name ..........: _Options
; Description ...:
; Syntax ........: _Options($sConfigFolder, $sConfigPath)
; Parameters ....: $sConfigFolder       - a string value.
;                  $sConfigPath         - a string value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Options($sConfigFolder, $sConfigPath)
	Local $hOptionsGui
	Local $idLanguage, $idAccessibility, $idAutocompleteFormula, $idApply
	Local $sCompleteOption, $sCompleteRead
	_config_start($sConfigFolder, $sConfigPath)
	$hOptionsGui = GUICreate("Options")
	$idLanguage = GUICtrlCreateButton("Change language, currently" & " " & $sLang, 10, 10, 120, 20)
	$idAccessibility = GUICtrlCreateButton("Enhanced accessibility enhabled: " & $sEnhancedAccess, 70, 10, 120, 20)
	GUICtrlCreateLabel("Choose autocompletion mode", 130, 10, 120, 20)
	$idAutocompleteFormula = GUICtrlCreateCombo("", 130, 70, 120, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	If $sFormulaAutocompletion = "1" Then
		$sCompleteRead = "GUI mode"
	Else
		$sCompleteRead = "Autocomplete mode"
	EndIf
	GUICtrlSetData($idAutocompleteFormula, "Autocomplete mode|GUI mode", $sCompleteRead)
	$idApply = GUICtrlCreateButton("&Apply", 210, 10, 200, 20)
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $idLanguage
				Selector()
				MsgBox(48, "Information", "Please restart Universal Calculator for the changes to take effect.")
				exitpersonaliced()
			Case $idAccessibility
				_configure_accessibility($sConfigPath)
			Case $idAutocompleteFormula
				$sCompleteOption = GUICtrlRead($idAutocompleteFormula)
				If $sCompleteOption = "GUI mode" Then
					IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "1")
				Else
					IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "2")
				EndIf
			Case -3 Or $idApply
				GUIDelete($hOptionsGui)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_Options
