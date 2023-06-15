; language manager:
#include <ComboConstants.au3>
#include <File.au3>
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
	Global $aLangFiles, $aLangCodes[]
	Global $bSelected = False
	Global $hLangGUI, $hLanguages
	Global $iOldOpt, $iSearch = 0
	Global $sCurrentCode = "", $sRead = "", $sCollect = "", $sCodes = ""
	$hLangGUI = GUICreate("Language Selection")
	$iOldOpt = Opt("GUIOnEventMode", 1)
	GUICtrlCreateLabel("Select language:", -1, 0)
	GUISetBkColor(0x00E0FFFF)
	$aLangFiles = _FileListToArrayRec(@ScriptDir & "\lng", "*.lang", 1, 0, 2)
	If @error Then
		MsgBox(16, "Fatal error", "We cannot find the language files. Please download the program again...")
		Exit
	EndIf
	For $I = 1 To $aLangFiles[0]
		$sCollect = $aLangFiles[$I]
		$sCurrentCode = StringLeft($sCollect, 2)
		$sCodes &= GetLanguageName($sCurrentCode) & ", " & GetLanguageCode($sCurrentCode) & "|"
		$aLangCodes[$I-1] = GetLanguageCode($sCurrentCode)
	Next
	$langcount = StringSplit($sCodes, "|")
	Global $Choose = GUICtrlCreateCombo("", 100, 50, 200, 30, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetOnEvent(-1, "LangSelect")
	GUICtrlSetData($Choose, $sCodes, IniRead($sConfigPath, "General settings", "language", ""))
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
	If Not $sRead = "" Then Global $queidiomaes = StringSplit($sRead, ",")
EndFunc   ;==>LangSelect
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
	If $sRead = "" Then
		MsgBox(16, "Error", "no language selected.")
	Else
		$bSelected = True
		IniWrite($sConfigPath, "General settings", "language", StringStripWS($queidiomaes[2], $STR_STRIPLEADING))
		$sLang = IniRead($sConfigPath, "General settings", "language", "")
	EndIf
EndFunc   ;==>save
