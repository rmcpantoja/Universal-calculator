; options:
#include <comboConstants.au3>
#include "configs.au3"
#include "globals.au3"
#include <GuiConstantsEx.au3>
;#include "keyboard.au3"
#include "language_manager.au3"
#include "..\menu_nvda.au3"
#include "..\translator.au3"
#include-once
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
	Local $iDeleteResult
	Local $idLanguage, $idAccessibility, $idAutocompleteFormula, $idShuwTips, $idApply
	Local $sCompleteOption, $sCompleteRead, $sTipsRead
	;_config_start($sConfigFolder, $sConfigPath)
	$hOptionsGui = GUICreate(translate($sLang, "Options"))
	$idLanguage = GUICtrlCreateButton(translate($sLang, "Change language, currently") & " " & GetLanguageName($sLang), 10, 10, 120, 20)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Allows the user to change the language of the program. More languages can be added by suggesting the author and reading the translation guide doc to contribute."))
	$idAccessibility = GUICtrlCreateButton(translate($sLang, "Enhanced accessibility enhabled:") & " " & translate($sLang, $sEnhancedAccessibility), 70, 10, 120, 20)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Allows the user to toggle Enhanced Accessibility. The enhanced accessibility feature is focused on improving the experience for people with visual impairments."))
	GUICtrlCreateLabel(translate($sLang, "Choose autocompletion mode:"), 130, 10, 120, 20)
	$idAutocompleteFormula = GUICtrlCreateCombo("", 130, 70, 120, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Changes the way you want to fill in the formulas, either by using a GUI to set the parameters or if you want to fill in the parameters manually in the interaction field, for this the respective command will be added first."))
	If $sFormulaAutocompletion = "1" Then
		$sCompleteRead = translate($sLang, "GUI mode")
	Else
		$sCompleteRead = translate($sLang, "Autocomplete mode")
	EndIf
	GUICtrlSetData($idAutocompleteFormula, translate($sLang, "Autocomplete mode") & "|" & translate($sLang, "GUI mode"), $sCompleteRead)
	$idShowTips = GUICtrlCreateCheckbox(translate($sLang, "Show tips"), 210, 10, 120, 20)
	If $sShowTips = "Yes" Then GUICtrlSetState(-1, $GUI_Checked)
	$idDeleteconfig = GUICtrlCreateButton(translate($sLang, "Clear settings"), 290, 210, 200, 20)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "This clears the current configs of the program, so it will be set to the default configs when it's reopened."))
	$idApply = GUICtrlCreateButton(translate($sLang, "&Apply"), 290, 80, 200, 20)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Saves the changes that have been made and close this window."))
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
			Case $idShowTips
				If _IsChecked($idShowTips) Then
					IniWrite($sConfigPath, "Calculator", "Show tips", "Yes")
				Else
					IniWrite($sConfigPath, "Calculator", "Show tips", "No")
				EndIf
			Case $idDeleteconfig
				$iDeleteResult = _DeleteSettings($sConfigPath)
				If @error Then
					MsgBox(16, translate($sLang, "Error"), translate($sLang, "Cannot delete configs file."))
				ElseIf $iDeleteResult = 1 Then
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
; Name ..........: _accessibility_Options
; Description ...:
; Syntax ........: _accessibility_Options($sConfigFolder, $sConfigPath)
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
Func _accessibility_Options($sConfigFolder, $sConfigPath)
	Local $hOptionsGui
	_accessibility_config_start($sConfigFolder, $sConfigPath)
	Local $sOptions = _
			translate($sLang, "Say the result when pressing the equal button") & "|" & _
			translate($sLang, "Enable / disable:") & " " & translate($sLang, "Announce position of items in menus and in lists") & "|" & _
			translate($sLang, "exit")
	$hOptionsGui = GUICreate(translate($sLang, "Accessibility options"))
	GUISetState(@SW_SHOW)
	Sleep(500)
	speaking(Translate($sLang, "Use up and down arrows to scroll through the options and enter to change them."))
	While 1
		$iMenu = reader_create_menu("Menu", $sOptions, $sReadPosition, translate($sLang, "OF"))
		Switch $iMenu
			Case 1
				If $sSpeak_result = "No" Then
					$sSpeak_result = "Yes"
				Else
					$sSpeak_result = "no"
				EndIf
				speaking(translate($sLang, $sSpeak_result), True)
				IniWrite($sConfigPath, "Accessibility", "Say result when pressing equal", $sSpeak_result)
			Case 2
				If $sReadPosition = "1" Then
					$sReadPosition = "0"
					speaking(translate($sLang, "Disabled"), True)
				Else
					$sReadPosition = "1"
					speaking(translate($sLang, "Enabled"), True)
				EndIf
				IniWrite($sConfigPath, "Accessibility", "Announce position", $sReadPosition)
			Case 3
				speaking(Translate($sLang, "Settings saved"), True)
				ExitLoop
		EndSwitch
		Sleep(100)
	WEnd
	GUIDelete($hOptionsGui)
EndFunc   ;==>_accessibility_Options
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
Func _DeleteSettings($sConfigPath)
	$iConfirm = MsgBox(4, translate($sLang, "Clear settings"), translate($sLang, "Are you sure?"))
	If $iConfirm = 6 Then
		$iDeleteResult = FileDelete($sConfigPath)
		If $iDeleteResult = 0 Then
			Return SetError(1, 0, "")
		Else
			Return 1
		EndIf
	Else ; if selected no:
		Return 2
	EndIf
EndFunc   ;==>_DeleteSettings
