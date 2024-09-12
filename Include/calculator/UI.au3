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
#include "..\mymath\NumTextNum_wrapper.au3"
#include "options.au3"
#include "params.au3"
#include "reasons.au3"
#include <StaticConstants.au3>
#include "..\mymath\Task_creator.au3"
#include "..\translator.au3"
#include <WindowsConstants.au3>
#include-once
; User interfaces for universal calculator:
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
	$hGui = GUICreate( _
			"Universal calculator " & $sProgramVer, 392, 432, 290, 257 _
			)
	GUISetBkColor(0x951722)
	$idMenu = GUICtrlCreateMenu(translate($sLang, "&Calculator"))
	$idHideKey = GUICtrlCreateMenuItem(translate($sLang, "hide keyboard") & @TAB & "CTRL+shift+k", $idMenu)
	GUICtrlSetState(-1, $GUI_Unchecked)
	$idOptions = GUICtrlCreateMenuItem(translate($sLang, "&Options") & @TAB & "ALT+o", $idMenu)
	$idMenuExit = GUICtrlCreateMenuItem(translate($sLang, "Exit"), $idMenu)
	$idBeginners = GUICtrlCreateMenu(translate($sLang, "&Tools"))
	;$idTasks = GUICtrlCreateMenu(translate($sLang, "Automatic task generation"), $idBeginners)
	;$iTaskGUI = GUICtrlCreateMenuItem(translate($sLang, "Generate and interact with the interface"), $idTasks)
	;$iTaskTxt = GUICtrlCreateMenuItem(translate($sLang, "Generate a text file"), $idTasks)
	$idN2w = GUICtrlCreateMenuItem(translate($sLang, "Numbers to words"), $idBeginners)
	$idBMI = GUICtrlCreateMenuItem(translate($sLang, "Body Mass Index"), $idBeginners)
	$idHelpmenu = GUICtrlCreateMenu(translate($sLang, "&Help"))
	$idChanges = GUICtrlCreateMenuItem(translate($sLang, "Changes"), $idHelpmenu)
	$idUserManual = GUICtrlCreateMenuItem(translate($sLang, "User manual"), $idHelpmenu)
	$idErrorReporting = GUICtrlCreateMenuItem(translate($sLang, "Errors and suggestions"), $idHelpmenu)
	$idGitHub = GUICtrlCreateMenuItem(translate($sLang, "Errors and suggestions (gitHub)"), $idHelpmenu)
	$idWebsite = GUICtrlCreateMenuItem(translate($sLang, "&Visit website"), $idHelpmenu)
	$idCheckUpdates = GUICtrlCreateMenuItem(translate($sLang, "Check for updates"), $idHelpmenu)
	If Not @Compiled Then GUICtrlSetState(-1, $GUI_DISABLE)
	$idAboutItem = GUICtrlCreateMenuItem(translate($sLang, "About"), $idHelpmenu)
	$idInterLabel = GUICtrlCreateLabel( _
			translate($sLang, "Write operation"), _
			10, 10, 370, 20, BitOR($SS_CENTERIMAGE, $SS_CENTER) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$idInter = GUICtrlCreateInput( _
			"", 10, 30, 370, 60 _
			)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetLimit(-1, 75)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Write your operation here, then press the equal button to get the result."))
	; creating the array of the on-screen keyboard, this is going to be manipulated.
	$aNums[0] = GUICtrlCreateButton( _
			"0", _
			187, 281, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[1] = GUICtrlCreateButton( _
			"1", _
			147, 241, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[2] = GUICtrlCreateButton( _
			"2", _
			187, 241, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[3] = GUICtrlCreateButton( _
			"3", _
			227, 241, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[4] = GUICtrlCreateButton( _
			"-", _
			267, 201, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "substract"))
	$aNums[5] = GUICtrlCreateButton( _
			"4", _
			147, 201, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[6] = GUICtrlCreateButton( _
			"5", _
			187, 201, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[7] = GUICtrlCreateButton( _
			"6", _
			227, 201, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[8] = GUICtrlCreateButton( _
			"*", _
			267, 161, 30, 30, BitOR($SS_CENTERIMAGE, $SS_CENTER) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "multiply"))
	$aNums[9] = GUICtrlCreateButton( _
			"7", _
			147, 161, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[10] = GUICtrlCreateButton( _
			"8", _
			187, 161, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[11] = GUICtrlCreateButton( _
			"9", _
			227, 161, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$aNums[12] = GUICtrlCreateButton( _
			"/", _
			267, 121, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "divide"))
	$aNums[13] = GUICtrlCreateButton( _
			".", _
			227, 281, 30, 30, $SS_CENTER _
			)
	GUICtrlSetFont(-1, 15)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Decimal point"))
	$aNums[14] = GUICtrlCreateButton( _
			"+", _
			267, 241, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "add"))
	$aNums[15] = GUICtrlCreateButton( _
			"%", _
			147, 281, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	GUICtrlSetColor(-1, 0x000000)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "percentage"))
	$aNums[16] = GUICtrlCreateButton( _
			"(", _
			147, 121, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Open parentheses"))
	$aNums[17] = GUICtrlCreateButton( _
			")", _
			187, 121, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Close parentheses"))
	$idEqual = GUICtrlCreateButton( _
			"&=", _
			267, 281, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Gets the result of your operation."))
	$idClearScreen = GUICtrlCreateButton( _
			"C", _
			227, 121, 30, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Clears the screen."))
	$idCommandsLb = GUICtrlCreateLabel( _
			Translate($sLang, "&Commands"), _
			10, 120, 130, 20, BitOR($SS_CENTERIMAGE, $SS_CENTER) _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, 0x828282)
	$idFORMULAS = GUICtrlCreateListView( _
			translate($sLang, "Name|Description|Command"), _
			10, 140, 130, 249, $LVS_SORTASCENDING _
			)
	GUICtrlSetColor(-1, 0x000000)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Here you can choose even more formulas that this calculator has to offer to you."))
	$idGetReason = GUICtrlCreateButton( _
			translate($sLang, "&Reason"), _
			307, 121, 70, 30 _
			)
	GUICtrlSetFont(-1, 10)
	GUICtrlSetColor(-1, 0x000000)
	If $sShowTips = "Yes" Then GUICtrlSetTip(-1, translate($sLang, "Gets the reason of why this operation does is equal to the other."))
	$idAbout = GUICtrlCreateButton( _
			translate($sLang, "&About"), _
			147, 321, 70, 50 _
			)
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
		if @error then
			MsgBox(16, "Error", "Can't convert keymap. Error code:" &@error)
			ExitLoop
		EndIf
		$aAccelKeys[$I][1] = $aNums[$I]
	Next
	$aAccelKeys[15][0] = "^+k"
	$aAccelKeys[15][1] = $idHideKey
	$aAccelKeys[16][0] = "^{bs}"
	$aAccelKeys[16][1] = $idClearScreen
	$aAccelKeys[17][0] = "!{o}"
	$aAccelKeys[17][1] = $idOptions
	if $sForceEnter = "Yes" then
		$aAccelKeys[18][0] = "{ENTER}"
		$aAccelKeys[18][1] = $idEqual
	else
	ReDim $aAccelKeys[uBound($aAccelKeys)-1][2]
	EndIf
	GUISetAccelerators($aAccelKeys)
	; show GUI:
	GUISetState(@SW_SHOW)
	While 1
		$idMsg = GUIGetMsg()
		Switch $idMsg
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
			Case $idN2w
				num2words_UI()
			Case $idBMI
				BMI_UI()
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
				If @error Then
					Switch @error
						Case 1
							MsgBox(16, translate($sLang, "Error"), translate($sLang, "Couldn't check for updates. Please check your internet connection."))
						Case 2
							MsgBox(16, translate($sLang, "Error"), translate($sLang, "Couldn't download files for this update."))
					EndSwitch
				EndIf
			Case $idAbout, $idAboutItem
				MsgBox( _
						48, _
						translate($sLang, "About"), _
						translate($sLang, "An easy, simple and interactive calculator where you can do operations, formulas, conversions and more. This program has been developed by Mateo Cedillo. Creation and design of the Graphical User Interface by Valeria Parra and Xx_Nessu_xX.") _
						)
			Case $GUI_EVENT_CLOSE, $idMenuExit
				ExitLoop
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
	$idEdit = GUICtrlCreateEdit($sContent, 5, 5, 390, 360, BitOR($WS_VSCROLL, $WS_HSCROLL, $WS_TABSTOP, $ES_READONLY))
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
	$hGui = GUICreate(translate($sLang, "Convert number to words"))
	; todo: multiple languages.
	$idLavelInput = GUICtrlCreateLabel( _
			translate($sLang, "Enter your number input"), _
			10, 10, 150, 20 _
			)
	$idInput = GUICtrlCreateInput( _
			"", 80, 10, 200, 20 _
			)
	$idResultlavel = GUICtrlCreateLabel( _
			translate($sLang, "Result"), _
			150, 10, 120, 20 _
			)
	GUICtrlSetState(-1, $GUI_HIDE)
	$idResultBox = GUICtrlCreateEdit( _
			"", 150, 80, 200, 20, BitOR($ES_READONLY, $ES_RIGHT), $WS_EX_STATICEDGE _
			)
	GUICtrlSetState(-1, $GUI_HIDE)
	$idClear = GUICtrlCreateButton( _
			translate($sLang, "Clear"), _
			150, 150, 200, 20 _
			)
	GUICtrlSetState(-1, $GUI_HIDE)
	$idConvert = GUICtrlCreateButton( _
			translate($sLang, "Convert"), _
			220, 10, 150, 20 _
			)
	; todo: Currencies and conversion modes:
	$idCancelBTN = GUICtrlCreateButton( _
			translate($sLang, "Cancel"), _
			220, 80, 150, 20 _
			)
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $idConvert
				$sTo_convert = GUICtrlRead($idInput)
				If Not $sTo_convert Or $sTo_convert == "" Then
					MsgBox(16, translate($sLang, "Error"), translate($sLang, "There's nothing to convert"))
					Return SetError(1, 0, "")
				EndIf
				$sWords = _NumTextNum_wrapper($sTo_convert, $sLang)
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

; #FUNCTION# ====================================================================================================================
; Name ..........: BMI_UI
; Description ...:
; Syntax ........: BMI_UI()
; Parameters ....: None
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func BMI_UI()
	Local $hGui
	Local $idHight, $idWeight, $idAge, $idCondition, $idResult, $idCancel
	$hGui = GUICreate(translate($sLang, "Body Mass Index"))
	GUICtrlCreateLabel( _
			translate($sLang, "What's your hight? (in meters)"), _
			10, 10, 150, 20 _
			)
	$idHight = GUICtrlCreateInput( _
			"", 70, 10, 200, 20 _
			)
	GUICtrlCreateLabel( _
			translate($sLang, "What's your weigth? (in kilos)"), _
			10, 80, 150, 20 _
			)
	$idWeight = GUICtrlCreateInput( _
			"", 80, 80, 200, 20 _
			)
	GUICtrlCreateLabel( _
			translate($sLang, "Age"), _
			150, 10, 150, 20 _
			)
	$idAge = GUICtrlCreateInput( _
			"18", 150, 80, 200, 10 _
			)
	GUICtrlCreateUpdown($idAge)
	$idCondition = GUICtrlCreateGroup( _
			translate($sLang, "Condition"), _
			220, 10, 10, 200 _
			)
	GUICtrlCreateRadio( _
			translate($sLang, "Pregnancy"), _
			250, 40, 100, 20 _
			)
	GUICtrlCreateRadio( _
			translate($sLang, "Diabetes"), _
			250, 60, 110, 50 _
			)
	GUICtrlCreateRadio( _
			translate($sLang, "Other"), _
			250, 80, 110, 50 _
			)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$idResult = GUICtrlCreateButton( _
			translate($sLang, "Get results"), _
			400, 80, 180, 20 _
			)
	$idCancel = GUICtrlCreateButton( _
			translate($sLang, "Cancel"), _
			400, 160, 180, 20 _
			)
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($hGui)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>BMI_UI

Func Generate_task()
EndFunc   ;==>Generate_task
