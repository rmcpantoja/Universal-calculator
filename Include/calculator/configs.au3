; configuration utils:
#include <ComboConstants.au3>
#include "globals.au3"
#include "language_manager.au3"
#include-once

func _config_start($sConfigFolder, $sConfigPath)
local $iAccesMSG
if not FileExists($sConfigFolder) Then DirCreate($sConfigFolder)
; beep progress bars:
$senableProgresses = IniRead($sConfigPath, "General settings", "Beep for progress bars", "")
If $senableProgresses = "" Then
	IniWrite($sConfigPath, "General settings", "Beep for progress bars", "No")
	$senableProgresses = "No"
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
EndFunc