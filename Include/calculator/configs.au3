; configuration utils:
#include <ComboConstants.au3>
#include "globals.au3"
#include "language_manager.au3"
#include "..\translator.au3"
#include "update_source.au3"
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _config_start
; Description ...: Start configuration for the program and, if necessary, set the default options.
; Syntax ........: _config_start($sConfigFolder, $sConfigPath)
; Parameters ....: $sConfigFolder       - a string value.
;                  $sConfigPath         - a string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _config_start($sConfigFolder, $sConfigPath)
	Local $iAccessMSG
	If Not FileExists($sConfigFolder) Then DirCreate($sConfigFolder)
	; beep progress bars:
	$sEnableProgresses = IniRead($sConfigPath, "General settings", "Beep for progress bars", "")
	If $sEnableProgresses = "" Then
		IniWrite($sConfigPath, "General settings", "Beep for progress bars", "No")
		$sEnableProgresses = "No"
	EndIf
	; check for language:
	$sLang = IniRead($sConfigPath, "General settings", "language", "")
	If $sLang = "" Then Selector()
	; check for enhanced accessibility
	$sEnhancedAccess = IniRead($sConfigPath, "Accessibility", "Enable enhanced accessibility", "")
	If Not $sEnhancedAccess = "Yes" Or Not $sEnhancedAccess = "No" Then
		$sEnhancedAccess = _configure_accessibility($sConfigPath)
	EndIf
	; Check formula autocompletion:
	$sFormulaAutocompletion = IniRead($sConfigPath, "Calculator", "formula autocompletion mode", "")
	If Not $sFormulaAutocompletion = "1" Or Not $sFormulaAutocompletion = "2" Then
		; Let's set the first default mode. This first mode makes that, when selecting a formula from the list, a GUI appears to complete the parameters to interact with it and get the final result.
		IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "1")
		$sFormulaAutocompletion = "1"
	EndIf
	; check last commit:
	if not @compiled then
		$sCommitGot = string(_calc_commit())
		$sCommit = string(IniRead($sConfigPath, "Update", "Last commit", ""))
		if $sCommit = "" then
			$sCommit = $sCommitGot
			IniWrite($sConfigPath, "Update", "Last commit", $sCommit)
		elseIf not $sCommit <> $sCommitGot then
			MsgBox(64, "New repository update", "A new update of the calculator was found. Press OK to apply it.")
			IniWrite($sConfigPath, "Update", "Last commit", $sCommitGot)
			_download_repo
		EndIf ; commit is empti or different
	EndIf ; compiled
	Return 1
EndFunc   ;==>_config_start
; #FUNCTION# ====================================================================================================================
; Name ..........: _ConfigureAccessibility
; Description ...:
; Syntax ........: _ConfigureAccessibility($sConfigPath)
; Parameters ....: $sConfigPath         - a string value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _Configure_Accessibility($sConfigPath)
	local $iAccessMSG = MsgBox(4, Translate($sLang, "Enable enhanced accessibility?"), Translate($sLang, "This new Enhanced Accessibility functionality is designed for the visually impaired, in which most of the program interface can be used by voice and keyboard shortcuts. Activate?"))
	local $sEnhancedAccess
	If $iAccessMSG = 6 Then
		IniWrite($sConfigPath, "accessibility", "Enable enhanced accessibility", "Yes")
		$sEnhancedAccess = "Yes"
	Else
		IniWrite($sConfigPath, "accessibility", "Enable enhanced accessibility", "No")
		$sEnhancedAccess = "No"
	EndIf
	return $sEnhancedAccess
EndFunc
func _calc_commit()
	$sCalcCommit = _GetLastCommit("rmcpantoja", "universal-calculator")
	if @error then
		switch @error
			case 1
				; skip for now:
			case 2
				MsgBox(16, "Error", "The last commit could not be determined.")
		endSwitch
	EndIf ; errors
	return $sCalcCommit
EndFunc
func _download_repo()
	$bDownloaded = _download_Github_repo("https://github.com/rmcpantoja/Universal-calculator/archive/main.zip", "calc.zip", @ScriptDir)
	if @error then
		switch @error
			case 1
				MsgBox(16, "Error", "Cannot connect to the server.")
			case 2
				MsgBox(16, "Error", "Could not download file :(")
		EndSwitch
	else
		MsgBox(64, "Success!", "Universal calculator updated successfully. Press OK to exit, then run the new version.")
		return $bDownloaded
		exit
	EndIf ; errors
EndFunc