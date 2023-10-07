; configuration utils:
#include <ComboConstants.au3>
#include "globals.au3"
#include "language_manager.au3"
#include "..\translator.au3"
#include "update.au3"
#include "update_source.au3"
#include "..\updater.au3"
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _config_start
; Description ...: Starts configuration for the program and, if necessary, set the default options.
; Syntax ........: _config_start($sConfigFolder, $sConfigPath)
; Parameters ....: $sConfigFolder       - The configs folder.
;                  $sConfigPath         - The full path to the config.ini or ST.
; Return values .: 1 if all is OK
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
	; check for language:
	$sLang = IniRead($sConfigPath, "General settings", "language", "")
	If $sLang = "" Then Selector()
	; Check for update:
	$sCheckForUpdate = IniRead($sConfigPath, "General settings", "Check updates", "")
	If $sCheckForUpdate = "" Then
		IniWrite($sConfigPath, "General settings", "Check updates", "Yes")
		$sCheckForUpdate = "Yes"
	EndIf
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
	; Check tips:
	$sShowTips = IniRead($sConfigPath, "Calculator", "Show tips", "")
	If $sShowTips = "" Then
		IniWrite($sConfigPath, "Calculator", "Show tips", "Yes")
		$sFormulaAutocompletion = "Yes"
	EndIf
	; check last commit:
	if not @compiled or $sCommitGot = "" then
		$sCommitGot = string(_calc_commit())
		$sCommit = string(IniRead($sConfigPath, "Update", "Last commit", ""))
		if $sCommit = "" then
			$sCommit = $sCommitGot
			IniWrite($sConfigPath, "Update", "Last commit", $sCommit)
		elseIf $sCommit <> $sCommitGot then
			if not $sCommitGot == "" then
				MsgBox(64, translate($sLang, "New repository update"), translate($sLang, "A new update of the calculator was found. Press OK to apply it."))
				IniWrite($sConfigPath, "Update", "Last commit", $sCommitGot)
				_download_repo()
			endIf ; got commit empti because the internet connection.
		EndIf ; commit is empti or different
	EndIf ; compiled
	; The configs has been sabed if they are empti. Now, check for update if is neccessary:
	if $sCheckForUpdate = "Yes" then
		$aUpdateHandler = checkupdate(@ScriptFullPath, "rmcpantoja/universal-calculator", True)
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
	EndIf
	Return 1
EndFunc   ;==>_config_start
; #FUNCTION# ====================================================================================================================
; Name ..........: _accessibility_config_start
; Description ...: Starts the config for accessibility purposes.
; Syntax ........: _accessibility_config_start($sConfigFolder, $sConfigPath)
; Parameters ....: $sConfigFolder       - The path to the configs folder.
;                  $sConfigPath         - The full path to the config ini or ST.
; Return values .: 1 if all is OK.
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _accessibility_config_start($sConfigFolder, $sConfigPath)
	If Not FileExists($sConfigFolder) Then DirCreate($sConfigFolder)
	; beep progress bars:
	$sEnableProgresses = IniRead($sConfigPath, "Accessibility", "Beep for progress bars", "")
	If $sEnableProgresses = "" Then
		IniWrite($sConfigPath, "Accessibility", "Beep for progress bars", "No")
		$sEnableProgresses = "No"
	EndIf
	; reader position:
	$sReadPosition = IniRead($sConfigPath, "Accessibility", "Announce position", "")
	If $sReadPosition = "" Then
		IniWrite($sConfigPath, "Accessibility", "Announce position", "1")
		$sReadPosition = "1"
	EndIf
	; Speak characters:
	$sSpeak_result = IniRead($sConfigPath, "Accessibility", "Say result when pressing equal", "")
	If $sSpeak_result = "" Then
		IniWrite($sConfigPath, "Accessibility", "Say result when pressing equal", "no")
		$sSpeak_result = "no"
	EndIf
	return 1
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _ConfigureAccessibility
; Description ...: Function that questions to the user if he want enhanced accessibility.
; Syntax ........: _ConfigureAccessibility($sConfigPath)
; Parameters ....: $sConfigPath         - The full path to the ini or ST.
; Return values .: The answered question.
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