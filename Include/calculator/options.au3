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
; Description ...: Function that runs the program options user interface.
; Syntax ........: _Options($sConfigFolder, $sConfigPath)
; Parameters ....: $sConfigFolder       - The folder to the configs.
;                  $sConfigPath         - the absolute path to the configuration file.
; Return values .: None
; Author ........: Mateo Cedillo
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
	$hOptionsGui = GUICreate(translate($sLang, "Options"))
	$idLanguage = GUICtrlCreateButton(translate($sLang, "Change language, currently") & " " & GetLanguageName($sLang), 10, 10, 120, 20)
	GuiCtrlSetTip(-1, translate($sLang, "Allows the user to change the language of the program. More languages can be added by suggesting the author and reading the translation guide doc to contribute."))
	$idAccessibility = GUICtrlCreateButton(translate($sLang, "Enhanced accessibility enhabled:") & " " & translate($sLang, $sEnhancedAccessibility), 70, 10, 120, 20)
	GuiCtrlSetTip(-1, translate($sLang, "Allows the user to toggle Enhanced Accessibility. The enhanced accessibility feature is focused on improving the experience for people with visual impairments."))
	GUICtrlCreateLabel(translate($sLang, "Choose autocompletion mode:"), 130, 10, 120, 20)
	$idAutocompleteFormula = GUICtrlCreateCombo("", 130, 70, 120, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GuiCtrlSetTip(-1, translate($sLang, "Changes the way you want to fill in the formulas, either by using a GUI to set the parameters or if you want to fill in the parameters manually in the interaction field, for this the respective command will be added first."))
	If $sFormulaAutocompletion = "1" Then
		$sCompleteRead = translate($sLang, "GUI mode")
	Else
		$sCompleteRead = translate($sLang, "Autocomplete mode")
	EndIf
	GUICtrlSetData($idAutocompleteFormula, translate($sLang, "Autocomplete mode") &"|" &translate($sLang, "GUI mode"), $sCompleteRead)
	$idDeleteconfig = GUICtrlCreateButton(translate($sLang, "Clear settings"), 210, 210, 200, 20)
	GuiCtrlSetTip(-1, translate($sLang, "This clears the current configs of the program, so it will be set to the default configs when it's reopened."))
	$idApply = GUICtrlCreateButton(translate($sLang, "&Apply"), 210, 80, 200, 20)
	GuiCtrlSetTip(-1, translate($sLang, "Saves the changes that have been made and close this window."))
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $idLanguage
				Selector()
				MsgBox(48, translate($sLang, "Information"), translate($sLang, "Please restart Universal Calculator for the changes to take effect."))
				exitpersonaliced()
			Case $idAccessibility
				_configure_accessibility($sConfigPath)
				MsgBox(48, translate($sLang, "Information"), translate($sLang, "Please restart Universal Calculator for the changes to take effect."))
				exitpersonaliced()
			Case $idAutocompleteFormula
				$sCompleteOption = GUICtrlRead($idAutocompleteFormula)
				If $sCompleteOption = translate($sLang, "GUI mode") Then
					IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "1")
				Else
					IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "2")
				EndIf
			case $idDeleteconfig
				$iDeleteResult = _DeleteSettings($sConfigPath)
				if @error then
					MsgBox(16, translate($sLang, "Error"), translate($sLang, "Cannot delete configs file."))
				Elseif $iDeleteResult = 1 then
					MsgBox(48, translate($sLang, "Information"), translate($sLang, "Please restart Universal Calculator for the changes to take effect."))
					Exitpersonaliced()
				EndIf
			Case $GUI_EVENT_CLOSE, $idApply
				GUIDelete($hOptionsGui)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_Options
; #FUNCTION# ====================================================================================================================
; Name ..........: _DeleteSettings
; Description ...: Function that deletes all program settings.
; Syntax ........: _DeleteSettings($sConfigPath)
; Parameters ....: $sConfigPath         - the absolute path of the configuration file to remove.
; Return values .: 1 if the settings have been cleared, @error if something went wrong, eg @error = 1 if the file was not found.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _DeleteSettings($sConfigPath)
	$iConfirm = MsgBox(4, translate($sLang, "Clear settings"), translate($sLang, "Are you sure?"))
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