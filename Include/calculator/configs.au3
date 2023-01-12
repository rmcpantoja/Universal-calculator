; configuration utils:
#include <ComboConstants.au3>
#include "globals.au3"
#include "language_manager.au3"
#include-once

func _config_start($sConfigFolder, $sConfigPath)
local $iAccesMSG
if not FileExists($sConfigFolder) Then DirCreate($sConfigFolder)
; beep progress bars:
$sEnableProgresses = IniRead($sConfigPath, "General settings", "Beep for progress bars", "")
If $sEnableProgresses = "" Then
	IniWrite($sConfigPath, "General settings", "Beep for progress bars", "No")
	$sEnableProgresses = "No"
EndIf
; check for language:
$sLang = IniRead($sConfigPath, "General settings", "language", "")
if $sLang = "" then Selector()
; check for enhanced accessibility
$sEnhancedAccess = IniRead($sConfigPath, "Accessibility", "Enable enhanced accessibility", "")
if not $sEnhancedAccess = "Yes" or not $sEnhancedAccess = "No" then
	$iAccesMSG = MsgBox(4, "Enable enhanced accessibility?", "This new Enhanced Accessibility functionality is designed for the visually impaired, in which most of the program interface can be used by voice and keyboard shortcuts. Activate?")
	if $iAccesMSG = 6 then
		IniWrite($sConfigPath, "accessibility", "Enable enhanced accessibility", "Yes")
		$sEnhancedAccess = "Yes"
	Else
		IniWrite($sConfigPath, "accessibility", "Enable enhanced accessibility", "No")
		$sEnhancedAccess = "No"
	EndIf
EndIf
; Check formula autocompletion:
$sFormulaAutocompletion = IniRead($sConfigPath, "Calculator", "formula autocompletion mode", "")
if not $sFormulaAutocompletion = "1" or not $sFormulaAutocompletion = "2" then
	; Let's set the first default mode. This first mode makes that, when selecting a formula from the list, a GUI appears to complete the parameters to interact with it and get the final result.
	IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "1")
	$sFormulaAutocompletion = "1"
EndIf
return 1
EndFunc