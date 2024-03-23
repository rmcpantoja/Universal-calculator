; configuration utils:
#include "checkupdate.au3"
#include <ComboConstants.au3>
#include "globals.au3"
#include "language_manager.au3"
#include "..\translator.au3"
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
	; Check for source code update:
	$sUpdateSource = IniRead($sConfigPath, "General settings", "Check source updates", "")
	If $sUpdateSource = "" and not @compiled Then
		IniWrite($sConfigPath, "General settings", "Check source updates", "Yes")
		$sUpdateSource = "Yes"
	EndIf
	; Check for update:
	$sCheckForUpdate = IniRead($sConfigPath, "General settings", "Check updates", "")
	If $sCheckForUpdate = "" and @compiled Then
		IniWrite($sConfigPath, "General settings", "Check updates", "Yes")
		$sCheckForUpdate = "Yes"
	EndIf
	; check for enhanced accessibility
	$sEnhancedAccessibility = IniRead($sConfigPath, "Accessibility", "Enable enhanced accessibility", "")
	If Not $sEnhancedAccessibility = "Yes" Or Not $sEnhancedAccessibility = "No" Then
		$sEnhancedAccessibility = _Configure_Accessibility($sConfigPath)
	EndIf
	; Check formula autocompletion:
	$sFormulaAutocompletion = IniRead($sConfigPath, "Calculator", "formula autocompletion mode", "")
	If Not $sFormulaAutocompletion = "1" Or Not $sFormulaAutocompletion = "2" Then
		; Let's set the first default mode. This first mode makes that, when selecting a formula from the list,
		; a GUI appears to complete the parameters to interact with it and get the final result.
		IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "1")
		$sFormulaAutocompletion = "1"
	EndIf
	; Force enter key:
	$sForceEnter = IniRead($sConfigPath, "Calculator", "Force enter key", "")
	If $sForceEnter = "" Then
		IniWrite($sConfigPath, "Calculator", "Force enter key", "Yes")
		$sForceEnter = "Yes"
	EndIf
	; Check tips:
	$sShowTips = IniRead($sConfigPath, "Calculator", "Show tips", "")
	If $sShowTips = "" Then
		IniWrite($sConfigPath, "Calculator", "Show tips", "Yes")
		$sShowTips = "Yes"
	EndIf
	; check last commit:
	If $sUpdateSource = "Yes" Then
		If Not @Compiled Or $sCommitGot = "" Then
			$sCommitGot = String(_calc_commit())
			$sCommit = String(IniRead($sConfigPath, "Update", "Last commit", ""))
			If $sCommit = "" Then
				$sCommit = $sCommitGot
				IniWrite($sConfigPath, "Update", "Last commit", $sCommit)
			ElseIf $sCommit <> $sCommitGot Then
				If Not $sCommitGot == "" Then
					MsgBox(64, translate($sLang, "New repository update"), translate($sLang, "A new update of the calculator was found. Press OK to apply it."))
					IniWrite($sConfigPath, "Update", "Last commit", $sCommitGot)
					_download_repo()
				EndIf ; got commit empti because the internet connection.
			EndIf ; commit is empti or different
		EndIf ; @compiled
	EndIf ; Check source code updates
	; The configs has been sabed if they are empti. Now, check for update if is neccessary:
	If $sCheckForUpdate = "Yes" Then
		If @Compiled Then _calc_check_update(True)
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
Func _accessibility_config_start($sConfigFolder, $sConfigPath)
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
	Return 1
EndFunc   ;==>_accessibility_config_start
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
Func _Configure_Accessibility($sConfigPath)
	Local $iAccessMSG = MsgBox(4, Translate($sLang, "Enable enhanced accessibility?"), Translate($sLang, "This new Enhanced Accessibility functionality is designed for the visually impaired, in which most of the program interface can be used by voice and keyboard shortcuts. Activate?"))
	Local $sEnhancedAccessibility
	If $iAccessMSG = 6 Then
		IniWrite($sConfigPath, "accessibility", "Enable enhanced accessibility", "Yes")
		$sEnhancedAccessibility = "Yes"
	Else
		IniWrite($sConfigPath, "accessibility", "Enable enhanced accessibility", "No")
		$sEnhancedAccessibility = "No"
	EndIf
	Return $sEnhancedAccessibility
EndFunc   ;==>_Configure_Accessibility
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
Func _calc_commit()
	$sCalcCommit = _GetLastCommit("rmcpantoja", "universal-calculator")
	If @error Then
		Switch @error
			Case 1
				; skip for now:
			Case 2
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "The last commit could not be determined."))
		EndSwitch
	EndIf ; errors
	Return $sCalcCommit
EndFunc   ;==>_calc_commit
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
Func _download_repo()
	$bDownloaded = _download_Github_repo("https://github.com/rmcpantoja/Universal-calculator/archive/main.zip", "calc.zip", @ScriptDir)
	If @error Then
		Switch @error
			Case 1
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "Cannot connect to the server."))
			Case 2
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "Could not download file :("))
			Case 3
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "The zip containing the repository could not be processed."))
		EndSwitch
	Else
		MsgBox(64, translate($sLang, "Success!"), translate($sLang, "Universal calculator updated successfully. Press OK to exit, then run the new version."))
		;return $bDownloaded
		Exit
	EndIf ; errors
EndFunc   ;==>_download_repo
