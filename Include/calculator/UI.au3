#include <array.au3>
#include <ButtonConstants.au3>
#include "calc.au3"
#include "checkupdate.au3"
#include "configs.au3"
#include <EditConstants.au3>
#include "formulas.au3"
#include "globals.au3"
#include <GuiConstantsEx.au3>
#include "keyboard.au3"
#include <ListViewConstants.au3>
#include "..\mymath\num2words.au3"
#include "options.au3"
#include "params.au3"
#include "reasons.au3"
#include <StaticConstants.au3>
#include "..\mymath\Task_creator.au3"
#include "..\translator.au3"
#include <WindowsConstants.au3>
#include-once
Global $aFlista = _SearchParam(Null, Default, True)
_ArrayColDelete($aFlista, 1, True)
; #FUNCTION# ====================================================================================================================
; Name ..........: Main
; Description ...: main program function.
; Syntax ........: Main()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func Main()
	; Creating GUI and its controls:
	;Note! No GUI acceleration is guaranteed for now, because I'm using the default and common message loop that everyone uses. In fact, I have already reported this in the NVDA code. Maybe a solution will be found: https://github.com/nvaccess/nvda/issues/13833
	$hGui = GUICreate("Universal calculator " & $sProgramVer, 392, 432, 290, 257)
	GUISetBkColor(0x951722)
	$idMenu = GUICtrlCreateMenu(translate($sLang, "&Calculator"))
	$idHideKey = GUICtrlCreateMenuItem(translate($sLang, "hide keyboard") & @TAB & "CTRL+shift+k", $idMenu)
	GUICtrlSetState(-1, $GUI_Unchecked)
	$idOptions = GUICtrlCreateMenuItem(translate($sLang, "&Options") & @TAB & "ALT+o", $idMenu)
	$idMenuExit = GUICtrlCreateMenuItem(translate($sLang, "Exit"), $idMenu)
	$idBeginners = GUICtrlCreateMenu(translate($sLang, "&Tools"))
	$idTasks = GUICtrlCreateMenu(translate($sLang, "Automatic task generation"), $idBeginners)
	$iTaskGUI = GUICtrlCreateMenuItem(translate($sLang, "Generate and interact with the interface"), $idTasks)
	$iTaskTxt = GUICtrlCreateMenuItem(translate($sLang, "Generate a text file"), $idTasks)
	$idN2w = GUICtrlCreateMenuItem(translate($sLang, "Numbers to words"), $idBeginners)
	$idHelpmenu = GUICtrlCreateMenu(translate($sLang, "&Help"))
	$idChanges = GUICtrlCreateMenuItem(translate($sLang, "Changes"), $idHelpmenu)
	$idUserManual = GUICtrlCreateMenuItem(translate($sLang, "User manual"), $idHelpmenu)
	$idErrorReporting = GUICtrlCreateMenuItem(translate($sLang, "Errors and suggestions"), $idHelpmenu)
	$idGitHub = GUICtrlCreateMenuItem(translate($sLang, "Errors and suggestions (gitHub)"), $idHelpmenu)
	$idWebsite = GUICtrlCreateMenuItem(translate($sLang, "&Visit website"), $idHelpmenu)
	$idCheckUpdates = GUICtrlCreateMenuItem(translate($sLang, "Check for updates"), $idHelpmenu)
	If Not @Compiled Then GUICtrlSetState(-1, $GUI_DISABLE)
	$idAboutItem = GUICtrlCreateMenuItem(translate($sLang, "About"), $idHelpmenu)
	$idInterLabel = GUICtrlCreateLabel(translate($sLang, "Write operation"), 10, 10, 370, 20, BitOR($SS_CENTERIMAGE, $SS_CENTER))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$idInter = GUICtrlCreateInput("", 10, 30, 370, 60)
	GUICtrlSetColor(-1, 0x000000)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Write your operation here, then press the equal button to get the result."))
	; creating the array of the on-screen keyboard, this is going to be manipulated.
	$aNums[0] = GUICtrlCreateButton("0", 187, 281, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[1] = GUICtrlCreateButton("1", 147, 241, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[2] = GUICtrlCreateButton("2", 187, 241, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[3] = GUICtrlCreateButton("3", 227, 241, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[4] = GUICtrlCreateButton("-", 267, 201, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "substract"))
	$aNums[5] = GUICtrlCreateButton("4", 147, 201, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[6] = GUICtrlCreateButton("5", 187, 201, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[7] = GUICtrlCreateButton("6", 227, 201, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[8] = GUICtrlCreateButton("*", 267, 161, 30, 30, BitOR($SS_CENTERIMAGE, $SS_CENTER))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "multiply"))
	$aNums[9] = GUICtrlCreateButton("7", 147, 161, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[10] = GUICtrlCreateButton("8", 187, 161, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[11] = GUICtrlCreateButton("9", 227, 161, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[12] = GUICtrlCreateButton("/", 267, 121, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "divide"))
	$aNums[13] = GUICtrlCreateButton(".", 227, 281, 30, 30, $SS_CENTER)
	GUICtrlSetFont(-1, 15)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Decimal point"))
	$aNums[14] = GUICtrlCreateButton("+", 267, 241, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "add"))
	$aNums[15] = GUICtrlCreateButton("%", 147, 281, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	GUICtrlSetColor(-1, 0x000000)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "percentage"))
	$aNums[16] = GUICtrlCreateButton("(", 147, 121, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Open parentheses"))
	$aNums[17] = GUICtrlCreateButton(")", 187, 121, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Close parentheses"))
	$idEqual = GUICtrlCreateButton("&=", 267, 281, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Gets the result of your operation."))
	$idClearScreen = GUICtrlCreateButton("C", 227, 121, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Clears the screen."))
	$idCommandsLb = GUICtrlCreateLabel(Translate($sLang, "&Commands"), 10, 120, 130, 20, BitOR($SS_CENTERIMAGE, $SS_CENTER))
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$idFORMULAS = GUICtrlCreateListView(translate($sLang, "Name|Description|Command"), 10, 140, 130, 249, $LVS_SORTASCENDING)
	GUICtrlSetColor(-1, 0x000000)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Here you can choose even more formulas that this calculator has to offer to you."))
	$idGetReason = GUICtrlCreateButton(translate($sLang, "&Reason"), 307, 121, 70, 30)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0x000000)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Gets the reason of why this operation does is equal to the other."))
	$idAbout = GUICtrlCreateButton(translate($sLang, "&About"), 147, 321, 70, 50)
	GUICtrlSetColor(-1, 0x000000)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Get info. about the program."))
	; we are going to add the information to the list of commands, functions or formulas:
	For $I = 0 To UBound($aInfoFormulas) - 1
		GUICtrlCreateListViewItem(Translate($sLang, $aInfoFormulas[$I]) & "|" & $aFlista[$I], $idFORMULAS)
	Next
	; setting key accelerators:
	Local $aAccelKeys[19][2]
	For $I = 0 To UBound($aNums) - 4
		$aAccelKeys[$I][0] = _convert_key_from_keymap($I)
		$aAccelKeys[$I][1] = $aNums[$I]
	Next
	$aAccelKeys[15][0] = "^+k"
	$aAccelKeys[15][1] = $idHideKey
	$aAccelKeys[16][0] = "^{bs}"
	$aAccelKeys[16][1] = $idClearScreen
	$aAccelKeys[17][0] = "!{o}"
	$aAccelKeys[17][1] = $idOptions
	$aAccelKeys[18][0] = "{ENTER}"
	$aAccelKeys[18][1] = $idEqual
	GUISetAccelerators($aAccelKeys)
	; show GUI:
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			; Calculator functions:
			; setting switch for keyboard keys:
			Case $aNums[0] To $aNums[17]
				For $I = 0 To UBound($aNums)
					If $idMsg = $aNums[$I] Then _addSymbol($hGui, $aNums[$I], $sEnhancedAccessibility, $bSpeak_numbers)
				Next
			Case $idHideKey
				_HideKey($aNums, $idHideKey, $bHideKeyboard)
			Case $idClearScreen
				_ClearScreen($idInter)
			Case $idEqual
				_calc($hGui, $idFORMULAS, $idInter, $idEqual)
			Case $idGetReason
				_GetReason($idInter, $sOperation)
			; Customization functions:
			Case $idOptions
				_Options($sConfigFolder, $sConfigPath)
			; Conversion and tools:
			case $idN2w
				num2words_UI()
			Case $idChanges
				_ReadDoc($sLang, "Changes")
			Case $idUserManual
				_ReadDoc($sLang, "Manual")
			Case $idErrorReporting
				ShellExecute("https://docs.google.com/forms/d/e/1FAIpQLSdDW6LqMKGHjUdKmHkAZdAlgSDilHaWQG9VZjwLz0CJSXKqHA/viewform?usp=sf_link")
				If @error Then MsgBox(16, translate($sLang, "Error"), translate($sLang, "Cannot run browser. It is likely that you have to add an association."))
			Case $idGitHub
				ShellExecute("https://github.com/rmcpantoja/universal-calculator/issues/new")
				If @error Then MsgBox(16, translate($sLang, "Error"), translate($sLang, "Cannot run browser. It is likely that you have to add an association."))
			Case $idWebsite
				ShellExecute("http://mateocedillo.260mb.net/")
				If @error Then MsgBox(16, translate($sLang, "Error"), translate($sLang, "Cannot run browser. It is likely that you have to add an association."))
			Case $idCheckUpdates
				_calc_check_update()
			Case $idAbout, $idAboutItem
				MsgBox(48, translate($sLang, "About"), translate($sLang, "An easy, simple and interactive calculator where you can do operations, formulas, conversions and more. This program has been developed by Mateo Cedillo. Creation and design of the Graphical User Interface by Valeria Parra and Xx_Nessu_xX."))
			Case $GUI_EVENT_CLOSE, $idMenuExit
				ExitPersonaliced()
		EndSwitch
	WEnd
EndFunc   ;==>Main
; #FUNCTION# ====================================================================================================================
; Name ..........: _ReadChanges
; Description ...: Read changes document
; Syntax ........: _ReadChanges()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _ReadDoc($sLang, $sTipe)
	Local $hGui
	Local $sContent, $sDocumentationPath = @ScriptDir & "\documentation\" & $sLang, $sGuiName
	If $sTipe = "Changes" Then
		$sDoc = $sDocumentationPath & "\changes.txt"
		$sGuiName = Translate($sLang, "Changes")
	ElseIf $sTipe = "Manual" Then
		$sGuiName = Translate($sLang, "User manual")
		$sDoc = $sDocumentationPath & "\manual.txt"
	Else
		Return SetError(1, 0, "")
	EndIf
	Local $hFile = FileOpen($sDoc, $FO_READ)
	If $hFile = -1 Then
		MsgBox(16, translate($sLang, "error"), translate($sLang, "An error occurred when reading the file."))
		Return SetError(2, 0, "")
	EndIf
	$sContent = FileRead($hFile)
	$hChangesGui = GUICreate($sGuiName)
	$idEdit = GUICtrlCreateEdit($sContent, 5, 5, 390, 360, BitOR($WS_VSCROLL, $WS_HSCROLL, $ES_READONLY))
	$idExit = GUICtrlCreateButton(translate($sLang, "&Close"), 100, 370, 150, 30)
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idExit
				FileClose($hFile)
				ExitLoop
		EndSwitch
	WEnd
	GUIDelete($hChangesGui)
EndFunc   ;==>_ReadDoc
; #FUNCTION# ====================================================================================================================
; Name ..........: num2words_UI
; Description ...: Graphical User Interphace for num2words support.
; Syntax ........: num2words_UI()
; Parameters ....: None
; Return values .: Set @error to 1 if text field is empty.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func num2words_UI()
	Local $sTo_convert, $sWords
	$hGui = GUICreate("Convert number to words")
	; todo: multiple languages.
	$idLavelInput = GUICtrlCreateLabel("Enter your number input", 10, 10, 150, 20)
	$idInput = GUICtrlCreateInput("", 80, 10, 200, 20)
	$idResultlavel = GUICtrlCreateLabel("Result", 150, 10, 120, 20)
	GUICtrlSetState(-1, $GUI_HIDE)
	$idResultBox = GUICtrlCreateEdit("", 150, 80, 200, 20, BitOR($ES_READONLY, $ES_RIGHT), $WS_EX_STATICEDGE)
	GUICtrlSetState(-1, $GUI_HIDE)
	$idClear = GUICtrlCreateButton("Clear", 150, 150, 200, 20)
	GUICtrlSetState(-1, $GUI_HIDE)
	$idConvert = GUICtrlCreateButton("Convert", 220, 10, 150, 20)
	; todo: Currencies and conversion modes:
	$idCancelBTN = GUICtrlCreateButton("Cancel", 220, 80, 150, 20)
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $idConvert
				$sTo_convert = GUICtrlRead($idInput)
				If Not $sTo_convert Or $sTo_convert == "" Then
					MsgBox(16, "Error", "there's nothing to convert")
					Return SetError(1, 0, "")
				EndIf
				$sWords = NumberToWords($sTo_convert)
				GUICtrlSetData($idResultBox, $sWords)
				GUICtrlSetState($idResultBox, $GUI_SHOW)
				GUICtrlSetState($idResultBox, $GUI_Focus)
				; Showing also clear button:
				GUICtrlSetState($idClear, $GUI_SHOW)
			Case $idClear
				GUICtrlSetData($idResultBox, "")
				GUICtrlSetState($idResultBox, $GUI_HIDE)
				GUICtrlSetState($idClear, $GUI_HIDE)
				GUICtrlSetState($idInput, $GUI_Focus)
			Case $idCancelBTN, $GUI_EVENT_CLOSE
				GUIDelete($hGui)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>num2words_UI

Func Generate_task()
EndFunc   ;==>Generate_task
