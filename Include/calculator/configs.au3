; configuration utils:
#include <ComboConstants.au3>
#include "globals.au3"
#include "language_manager.au3"
#include-once

func _config_start($sConfigFolder, $sConfigPath)
if not FileExists($sConfigFolder) Then DirCreate($sConfigFolder)
; beep progress bars:
$sEnhableProgresses = IniRead($sConfigPath, "General settings", "Beep for progress bars", "")
If $sEnhableProgresses = "" Then
	IniWrite($sConfigPath, "General settings", "Beep for progress bars", "No")
	$sEnhableProgresses = "No"
EndIf
; check for language:
$sLang = IniRead($sConfigPath, "General settings", "language", "")
if $sLang = "" then
Selector()
EndIf
; check for enhanced accessibility
$sEnhancedAccess = IniRead($sConfigPath, "Accessibility", "Enable enhanced accessibility", "")
EndFunc