; options:
#include <comboConstants.au3>
#include "configs.au3"
#include "globals.au3"
#include <GuiConstantsEx.au3>
;#include "keyboard.au3"
#include "language_manager.au3"
#include "..\menu_nvda.au3"
#Include "..\Restart.au3"
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
	local $bDeleteResult, $bRestartRequired = False
	Local $hOptionsGui
	Local $idLanguage, $idAccessibility, $idAutocompleteFormula, $idForceEqualKey, $idShowTips, $idApply
	Local $sCompleteOption, $sCompleteRead, $sTipsRead
	;_config_start($sConfigFolder, $sConfigPath)
	$hOptionsGui = GUICreate(translate($sLang, "Options"))
	$idLanguage = GUICtrlCreateButton( _
			translate($sLang, "Change language, currently") & " " & GetLanguageName($sLang), _
			10, 10, 120, 20 _
			)
	If $sShowTips = "Yes" Then
		GUICtrlSetTip(-1, _
				translate($sLang, "Allows the user to change the language of the program. More languages can be added by suggesting the author and reading the translation guide doc to contribute.") _
				)
	EndIf
	$idAccessibility = GUICtrlCreateButton( _
			translate($sLang, "Enhanced accessibility enhabled:") & " " & translate($sLang, $sEnhancedAccessibility), _
			70, 10, 120, 20 _
			)
	If $sShowTips = "Yes" Then
		GUICtrlSetTip( _
				-1, _
				translate($sLang, "Allows the user to toggle Enhanced Accessibility. The enhanced accessibility feature is focused on improving the experience for people with visual impairments.") _
				)
	EndIf
	GUICtrlCreateLabel( _
			translate($sLang, "Choose autocompletion mode:"), _
			130, 10, 120, 20 _
			)
	$idAutocompleteFormula = GUICtrlCreateCombo( _
			"", 130, 70, 120, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL) _
			)
	If $sShowTips = "Yes" Then
		GUICtrlSetTip(-1, _
				translate($sLang, "Changes the way you want to fill in the formulas, either by using a GUI to set the parameters or if you want to fill in the parameters manually in the interaction field, for this the respective command will be added first.") _
				)
	EndIf
	If $sFormulaAutocompletion = "1" Then
		$sCompleteRead = translate($sLang, "GUI mode")
	Else
		$sCompleteRead = translate($sLang, "Autocomplete mode")
	EndIf
	GUICtrlSetData( _
			$idAutocompleteFormula, _
			translate($sLang, "Autocomplete mode") & "|" & translate($sLang, "GUI mode"), _
			$sCompleteRead _
			)
	$idForceEqualKey = GUICtrlCreateCheckbox( _
			translate($sLang, "Force enter key to do the equal function"), _
			210, 10, 120, 20 _
			)
	If $sForceEnter = "Yes" Then GUICtrlSetState(-1, $GUI_Checked)
	If $sShowTips = "Yes" Then
		GUICtrlSetTip(-1, _
				translate($sLang, "When the equal button is pressed, it will activate the enter key as a shortcut. Please note that if you're a screen reader user and want to use a control, you will need to do so using the spacebar.") _
				)
	EndIf
	$idShowTips = GUICtrlCreateCheckbox( _
			translate($sLang, "Show tips"), _
			210, 90, 120, 20 _
			)
	If $sShowTips = "Yes" Then GUICtrlSetState(-1, $GUI_Checked)
	$idDeleteconfig = GUICtrlCreateButton( _
			translate($sLang, "Clear settings"), _
			290, 210, 200, 20 _
			)
	If $sShowTips = "Yes" Then
		GUICtrlSetTip(-1, _
				translate($sLang, "This clears the current configs of the program, so it will be set to the default configs when it's reopened.") _
				)
	EndIf
	$idApply = GUICtrlCreateButton( _
			translate($sLang, "&Apply"), _
			290, 80, 200, 20 _
	)
	If $sShowTips = "Yes" Then
		GUICtrlSetTip(-1, translate($sLang, "Saves the changes that have been made and close this window."))
	EndIf
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $idLanguage
				$bRestartRequired = Selector()
			Case $idAccessibility
				if Not $sEnhancedAccessibility = _configure_accessibility($sConfigPath) then $bRestartRequired = True
			Case $idAutocompleteFormula
				$sCompleteOption = GUICtrlRead($idAutocompleteFormula)
				If $sCompleteOption = translate($sLang, "GUI mode") Then
					IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "1")
				Else
					IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "2")
				EndIf
			case $idForceEqualKey
				If _IsChecked($idForceEqualKey) Then
					IniWrite($sConfigPath, "Calculator", "Force enter key", "Yes")
				Else
					IniWrite($sConfigPath, "Calculator", "Force enter key", "No")
				EndIf
			Case $idShowTips
				If _IsChecked($idShowTips) Then
					IniWrite($sConfigPath, "Calculator", "Show tips", "Yes")
				Else
					IniWrite($sConfigPath, "Calculator", "Show tips", "No")
				EndIf
			Case $idDeleteconfig
				$bDeleteResult = _DeleteSettings($sConfigPath)
				If @error Then
					MsgBox(16, translate($sLang, "Error"), translate($sLang, "Cannot delete configs file."))
				ElseIf $bDeleteResult Then
					$bRestartRequired = True
				EndIf
			Case $GUI_EVENT_CLOSE, $idApply
				GUIDelete($hOptionsGui)
				if $bRestartRequired then _restart_dialog()
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_Options

func _restart_dialog()
	local $iAnswer
	$iAnswer = MsgBox(4, _
			translate($sLang, "Information"), _
			translate($sLang, "Please restart Universal Calculator for the changes to take effect. Do you want to restart now?") _
			)
	if $iAnswer == 6 then
		_ScriptRestart()
	else
		return False
	EndIf
EndFunc

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
			Return True
		EndIf
	Else ; if selected no:
		Return False
	EndIf
EndFunc   ;==>_DeleteSettings
