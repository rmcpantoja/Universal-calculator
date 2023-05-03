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
	local $iDeleteResult
	Local $idLanguage, $idAccessibility, $idAutocompleteFormula, $idApply
	Local $sCompleteOption, $sCompleteRead
	_config_start($sConfigFolder, $sConfigPath)
	$hOptionsGui = GUICreate("Options")
	$idLanguage = GUICtrlCreateButton("Change language, currently" & " " & $sLang, 10, 10, 120, 20)
	GuiCtrlSetTip(-1, "Allows the user to change the language of the program. More languages can be added by suggesting the author and reading the translation guide doc to contribute.")
	$idAccessibility = GUICtrlCreateButton("Enhanced accessibility enhabled: " & $sEnhancedAccessibility, 70, 10, 120, 20)
	GuiCtrlSetTip(-1, "Allows the user to toggle Enhanced Accessibility. The enhanced accessibility feature is focused on improving the experience for people with visual impairments.")
	GUICtrlCreateLabel("Choose autocompletion mode:", 130, 10, 120, 20)
	$idAutocompleteFormula = GUICtrlCreateCombo("", 130, 70, 120, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GuiCtrlSetTip(-1, "Changes the way you want to fill in the formulas, either by using a GUI to set the parameters or if you want to fill in the parameters manually in the interaction field, for this the respective command will be added first.")
	If $sFormulaAutocompletion = "1" Then
		$sCompleteRead = "GUI mode"
	Else
		$sCompleteRead = "Autocomplete mode"
	EndIf
	GUICtrlSetData($idAutocompleteFormula, "Autocomplete mode|GUI mode", $sCompleteRead)
	$idDeleteconfig = GUICtrlCreateButton("clear settings", 210, 210, 200, 20)
	GuiCtrlSetTip(-1, "This clears the current configs of the program, so it will be set to the default configs when it's reopened.")
	$idApply = GUICtrlCreateButton("&Apply", 210, 80, 200, 20)
	GuiCtrlSetTip(-1, "Saves the changes that have been made and close this window.")
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
			case $idDeleteconfig
				$iDeleteResult = _DeleteSettings($sConfigPath)
				if @error then
					MsgBox(16, "Error", "Cannot delete configs file.")
				Elseif $iDeleteResult = 1 then
					MsgBox(48, translate($lng, "Information"), translate($lng, "Please restart Universal Calculator for the changes to take effect."))
					Exitpersonaliced()
				EndIf
			Case $GUI_EVENT_CLOSE, $idApply
				GUIDelete($hOptionsGui)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_Options
func _DeleteSettings($sConfigPath)
	$iConfirm = MsgBox(4, "Clear settings", "Are you sure?")
	if $iConfirm = 6 then
		$iDeleteResult = FileDelete($sConfigPath)
		If $iDeleteResult = 0 Then
			return SetError(1, 0, "")
		Else
			return 1
		EndIf
	else ; if selected no:
		return 2
	EndIf
EndFunc