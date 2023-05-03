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
	$sEnhancedAccessibility = IniRead($sConfigPath, "Accessibility", "Enable enhanced accessibility", "")
	If Not $sEnhancedAccessibility = "Yes" Or Not $sEnhancedAccessibility = "No" Then
		$sEnhancedAccessibility = _configure_accessibility($sConfigPath)
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
		elseIf $sCommit <> $sCommitGot then
			MsgBox(64, translate($sLang, "New repository update"), translate($sLang, "A new update of the calculator was found. Press OK to apply it."))
			IniWrite($sConfigPath, "Update", "Last commit", $sCommitGot)
			_download_repo()
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
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _Configure_Accessibility($sConfigPath)
	local $iAccessMSG = MsgBox(4, Translate($sLang, "Enable enhanced accessibility?"), Translate($sLang, "This new Enhanced Accessibility functionality is designed for the visually impaired, in which most of the program interface can be used by voice and keyboard shortcuts. Activate?"))
	local $sEnhancedAccessibility
	If $iAccessMSG = 6 Then
		IniWrite($sConfigPath, "accessibility", "Enable enhanced accessibility", "Yes")
		$sEnhancedAccessibility = "Yes"
	Else
		IniWrite($sConfigPath, "accessibility", "Enable enhanced accessibility", "No")
		$sEnhancedAccessibility = "No"
	EndIf
	return $sEnhancedAccessibility
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _calc_commit
; Description ...: Gets the last commit of the universal calculator project.
; Syntax ........: _calc_commit()
; Parameters ....: None
; Return values .: The last commit
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
func _calc_commit()
	$sCalcCommit = _GetLastCommit("rmcpantoja", "universal-calculator")
	if @error then
		switch @error
			case 1
				; skip for now:
			case 2
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "The last commit could not be determined."))
		endSwitch
	EndIf ; errors
	return $sCalcCommit
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _download_repo
; Description ...: Function that downloads the latest universal calculator source code.
; Syntax ........: _download_repo()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
func _download_repo()
	$bDownloaded = _download_Github_repo("https://github.com/rmcpantoja/Universal-calculator/archive/main.zip", "calc.zip", @ScriptDir)
	if @error then
		switch @error
			case 1
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "Cannot connect to the server."))
			case 2
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "Could not download file :("))
			case 3
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "The zip containing the repository could not be processed."))
		EndSwitch
	else
		MsgBox(64, translate($sLang, "Success!"), translate($sLang, "Universal calculator updated successfully. Press OK to exit, then run the new version."))
		;return $bDownloaded
		exit
	EndIf ; errors
EndFunc