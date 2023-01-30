#include <array.au3>
#include <ButtonConstants.au3>
#include "calc.au3"
#include "configs.au3"
#include "formulas.au3"
#include "globals.au3"
#include <GuiConstantsEx.au3>
#include "keyboard.au3"
#include <ListViewConstants.au3>
#include "params.au3"
#include "reasons.au3"
#include <StaticConstants.au3>
#include "..\mymath\Task_creator.au3"
#include "..\translator.au3"
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
	$hGUI = GUICreate("Universal calculator " & $sProgramVer, 400, 350, 290, 257)
	$idMenu = GUICtrlCreateMenu(translate($sLang, "&Calculator"))
	$idHideKey = GUICtrlCreateMenuItem(translate($sLang, "hide keyboard") & @TAB & "CTRL+shift+k", $idMenu)
	GUICtrlSetState(-1, $GUI_Unchecked)
	$idMenuExit = GUICtrlCreateMenuItem(translate($sLang, "Exit"), $idMenu)
	$idBeginners = GUICtrlCreateMenu(translate($sLang, "&Tools for Beginners"))
	$idTasks = GUICtrlCreateMenu(translate($sLang, "Automatic task generation"), $idBeginners)
	$iTaskGUI = GUICtrlCreateMenuItem(translate($sLang, "Generate and interact with the interface"), $idTasks)
	$iTaskTxt = GUICtrlCreateMenuItem(translate($sLang, "Generate a text file"), $idTasks)
	$idInterLabel = GUICtrlCreateLabel(translate($sLang, "Write operation"), 10, 10, 160, 90)
	GUICtrlSetColor(-1, 0x000000)
	$idInter = GUICtrlCreateInput("", 170, 0, 220, 110)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "Write your operation here, then press the equal button to get the result."))
	; creating the array of the on-screen keyboard, this is going to be manipulated.
	$aNums[0] = GUICtrlCreateButton("0", 140, 280, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[1] = GUICtrlCreateButton("1", 140, 240, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[2] = GUICtrlCreateButton("2", 180, 240, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[3] = GUICtrlCreateButton("3", 220, 240, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[4] = GUICtrlCreateButton("-", 250, 240, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "substract"))
	$aNums[5] = GUICtrlCreateButton("4", 130, 200, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[6] = GUICtrlCreateButton("5", 170, 200, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[7] = GUICtrlCreateButton("6", 210, 200, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[8] = GUICtrlCreateButton("*", 250, 200, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "multiply"))
	$aNums[9] = GUICtrlCreateButton("7", 130, 160, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[10] = GUICtrlCreateButton("8", 170, 160, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[11] = GUICtrlCreateButton("9", 210, 160, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[12] = GUICtrlCreateButton("/", 250, 160, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "divide"))
	$aNums[13] = GUICtrlCreateButton(".", 170, 280, 30, 30, BitOR($SS_CENTER, 0, 0))
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "Decimal point"))
	$aNums[14] = GUICtrlCreateButton("+", 260, 280, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "add"))
	$aNums[15] = GUICtrlCreateButton("%", 130, 130, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "percentage"))
	$aNums[16] = GUICtrlCreateButton("(", 160, 130, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "Open parentheses"))
	$aNums[17] = GUICtrlCreateButton(")", 200, 130, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "Close parentheses"))
	$idEqual = GUICtrlCreateButton("&=", 220, 280, 30, 30, BitOR($SS_CENTER, 0, 0))
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "Gets the result of your operation."))
	$idClearScreen = GUICtrlCreateButton("C", 240, 130, 30, 30)
	GUICtrlSetTip(-1, translate($sLang, "Clears the screen."))
	$idCommandsLb = GUICtrlCreateLabel(Translate($sLang, "&Commands"), 280, 170, 80, 30)
	GUICtrlSetColor(-1, 0x000000)
	$idFORMULAS = GUICtrlCreateListView(translate($sLang, "Name|Description|Command"), 10, 110, 90, 149, $LVS_SORTASCENDING)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "Here you can choose even more formulas that this calculator has to offer to you."))
	$idOptions = GUICtrlCreateButton(translate($sLang, "&Options"), 40, 260, 60, 70)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "Configure the program to your preference."))
	$idGetReason = GUICtrlCreateButton(translate($sLang, "&Reason"), 280, 110, 40, 50, -1)
	GUICtrlSetTip(-1, translate($sLang, "Gets the reason of why this operation does is equal to the other."))
	$idAbout = GUICtrlCreateButton(translate($sLang, "&About"), 280, 210, 80, 50)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, translate($sLang, "Get info. about the program."))
	; we are going to add the information to the list of commands, functions or formulas:
	For $I = 0 To UBound($aInfoFormulas) - 1
		GUICtrlCreateListViewItem($aInfoFormulas[$I] & "|" & $aFlista[$I], $idFORMULAS)
	Next
	; setting key accelerators:
	Local $aAccelKeys[][2] = [["^+k", $idHideKey], ["^{bs}", $idClearScreen]]
	GUISetAccelerators($aAccelKeys)
	; show GUI:
	GUISetState(@SW_SHOW)
	While 1
		$idMsg = GUIGetMsg()
		Switch $idMsg
			; setting switch for keyboard keys:
			Case $aNums[0] To $aNums[17]
				For $I = 0 To UBound($aNums)
					If $idMsg = $aNums[$I] Then _addSymbol($hGui, $aNums[$I])
				Next
			Case $idHideKey
				_HideKey($aNums, $idHideKey, $bHideKeyboard)
			Case $idClearScreen
				_ClearScreen($idInter)
			Case $idEqual
				_calc()
			Case $idOptions
				MsgBox(0, "No disponible", "Pronto abrá, pero voy a hacer un to do o ideas: 1, enfocar la pantalla de resultados al realizar una operación o que te la hable el lector directamente. 2, idioma inglés. 3, mostrar automáticamente la razón en una operción en caso de que sean operaciones avanzadas como raíces, potencias etc.")
			Case $idGetReason
				_GetReason()
			Case $idAbout
				MsgBox(48, translate($sLang, "About"), translate($sLang, "An easy, simple and interactive calculator where you can do operations, formulas, conversions and more. This program has been developed by Mateo Cedillo. Creation of the GUI by Valeria Parra."))
			Case $GUI_EVENT_CLOSE, $idMenuExit
				ExitPersonaliced()
		EndSwitch
	WEnd
EndFunc   ;==>Main
Func Generate_task()
EndFunc