; language manager:
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
	Local $widthCell, $msg, $iOldOpt
	global $leer
	Global $langGUI = GUICreate("Language Selection")
	Global $seleccionado = "0"
	$widthCell = 70
	$iOldOpt = Opt("GUIOnEventMode", 1)
	$beep = "0"
	$busqueda = "0"
	global $langcodes[]
	GUICtrlCreateLabel("Select language:", -1, 0)
	GUISetBkColor(0x00E0FFFF)
	$recolectalosidiomasporfavor = FileFindFirstFile(@ScriptDir & "\lng\*.lang")
	If $recolectalosidiomasporfavor = -1 Then
		MsgBox(16, "Fatal error", "We cannot find the language files. Please download the program again...")
exit()
	EndIf
	Local $Recoleccion = "", $obteniendo = ""
	While 1
		$beep = $beep + 1
		$busqueda = $busqueda + 1
		$Recoleccion = FileFindNextFile($recolectalosidiomasporfavor)
		If @error Then
			;MsgBox(16, "Error", "We cannot find the language files or they are corrupted.")
			If $enhableprogresses = "yes" Then CreateAudioProgress("100")
			ExitLoop
		EndIf
		$splitCode = StringLeft($Recoleccion, 2)
		$obteniendo &= GetLanguageName($splitCode) & ", " & GetLanguageCode($splitCode) & "|"
		$langcodes[$busqueda] = GetLanguageCode($splitCode)
		If $enhableprogresses = "yes" Then CreateAudioProgress($beep)
		Sleep(10)
	WEnd
	$langcount = StringSplit($obteniendo, "|")
	Global $Choose = GUICtrlCreateCombo("", 100, 50, 200, 30, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetOnEvent(-1, "seleccionar")
	GUICtrlSetData($Choose, $obteniendo)
	Global $idBtn_OK = GUICtrlCreateButton("OK", 155, 50, 70, 30)
	GUICtrlSetOnEvent(-1, "save")
	Global $idBtn_Close = GUICtrlCreateButton("Close", 180, 50, 70, 30)
	GUICtrlSetOnEvent(-1, "exitpersonaliced")
	GUISetState(@SW_SHOW)
	Global $LEER = ""
	While 1
		If $seleccionado = "1" Then ExitLoop
	WEnd
	GUIDelete($langGUI)
	Opt("GUIOnEventMode", $iOldMode)
EndFunc   ;==>Selector
; #FUNCTION# ====================================================================================================================
; Name ..........: seleccionar
; Description ...: It is a small but great function that helps to collect the language selected by the user through the GUI
; Syntax ........: seleccionar()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func seleccionar()
	$LEER = GUICtrlRead($Choose)
	if not $LEER = "" then global $queidiomaes = StringSplit($LEER, ",")
EndFunc   ;==>seleccionar
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
	if $leer = "" then
		MsgBox(16, "Error", "no language selected.")
	Else
		$seleccionado = "1"
		IniWrite($ConfigPath, "General settings", "language", StringStripWS($queidiomaes[2], $STR_STRIPLEADING))
		$lng = IniRead($ConfigPath, "General settings", "language", "")
	EndIf
EndFunc   ;==>save