; language manager:
#include <ComboConstants.au3>
#include "globals.au3"
#include "..\translator.au3"
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: Selector
; Description ...: language selector
; Syntax ........: Selector()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func Selector()
	global $aLangCodes[]
	Global $bSelected = False
	Global $hLangGUI, $hLanguages
	global $iOldOpt, $iSearch = 0
	global $sCurrentCode = "", $sRead = "", $sCollect = "", $sCodes = ""
	$hLangGUI = GUICreate("Language Selection")
	$iOldOpt = Opt("GUIOnEventMode", 1)
	GUICtrlCreateLabel("Select language:", -1, 0)
	GUISetBkColor(0x00E0FFFF)
	$hLanguages = FileFindFirstFile(@ScriptDir & "\lng\*.lang")
	If $hLanguages = -1 Then
		MsgBox(16, "Fatal error", "We cannot find the language files. Please download the program again...")
exit
	EndIf
	While 1
		$iSearch = $iSearch + 1
		$sCollect = FileFindNextFile($hLanguages)
		If @error Then
			;MsgBox(16, "Error", "We cannot find the language files or they are corrupted.")

			ExitLoop
		EndIf
		$sCurrentCode = StringLeft($sCollect, 2)
		$sCodes &= GetLanguageName($sCurrentCode) & ", " & GetLanguageCode($sCurrentCode) & "|"
		$aLangCodes[$iSearch] = GetLanguageCode($sCurrentCode)
		Sleep(10)
	WEnd
	$langcount = StringSplit($sCodes, "|")
	Global $Choose = GUICtrlCreateCombo("", 100, 50, 200, 30, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetOnEvent(-1, "LangSelect")
	GUICtrlSetData($Choose, $sCodes)
	Global $idBtn_OK = GUICtrlCreateButton("OK", 155, 50, 70, 30)
	GUICtrlSetOnEvent(-1, "save")
	Global $idBtn_Close = GUICtrlCreateButton("Close", 180, 50, 70, 30)
	GUICtrlSetOnEvent(-1, "exitpersonaliced")
	GUISetState(@SW_SHOW)
	While 1
		If $bSelected Then ExitLoop
	WEnd
	GUIDelete($hLangGUI)
	Opt("GUIOnEventMode", $iOldOpt)
EndFunc   ;==>Selector
; #FUNCTION# ====================================================================================================================
; Name ..........: select
; Description ...: It is a small but great function that helps to collect the language selected by the user through the GUI
; Syntax ........: select()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LangSelect()
	$sRead = GUICtrlRead($Choose)
	if not $sRead = "" then global $queidiomaes = StringSplit($sRead, ",")
EndFunc   ;==>select
; #FUNCTION# ====================================================================================================================
; Name ..........: save
; Description ...: This function saves the language selected by the user when running for the first time
; Syntax ........: save()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func save()
	if $sRead = "" then
		MsgBox(16, "Error", "no language selected.")
	Else
		$bSelected = True
		IniWrite($sConfigPath, "General settings", "language", StringStripWS($queidiomaes[2], $STR_STRIPLEADING))
		$sLang = IniRead($sConfigPath, "General settings", "language", "")
	EndIf
EndFunc   ;==>save