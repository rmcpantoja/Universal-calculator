#include <array.au3>
#include <ButtonConstants.au3>
#include "calc.au3"
#include "configs.au3"
#include "formulas.au3"
#include "globals.au3"
#include "..\Glance\glance.au3"
#include "keyboard.au3"
#include <ListViewConstants.au3>
#include "options.au3"
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
	$hGUI = glf_NewForm("Universal calculator " & $sProgramVer, 400, 350, 290, 257)
	glf_FormCreateHwnd($hGui)
	glf_FormAddMenuBar($hGui, "&Calculator|&Tools for Beginners")
	glf_FormAddMenuItems($hGui, "&Calculator", translate($sLang, "hide keyboard") & @TAB & "CTRL+shift+k" & "|" & translate($sLang, "Exit"))
	glf_FormAddMenuItems($hGui, "&Tools for Beginners", translate($sLang, "Automatic task generation") &"|" & translate($sLang, "Generate and interact with the interface") & "|" & translate($sLang, "Generate a text file"))
	$idInterLabel = glf_NewLabel($hGui, translate($sLang, "Write operation"), 10, 10, 160, 90)
	glf_ControlSetProperty($idInterLabel, $idInterLabel.foreColor, 0x000000)
	$idInter = glf_NewTextBox($hGui, "", 170, 0, 220, 110)
	glf_ControlSetProperty($idInter, $idInter.foreColor, 0x000000)
	; creating the array of the on-screen keyboard, this is going to be manipulated.
	$aNums[0] = glf_NewButton($hGui, "0", 140, 280, 30, 30)
	$aNums[1] = glf_NewButton($hGui, "1", 140, 240, 30, 30)
	$aNums[2] = glf_NewButton($hGui, "2", 180, 240, 30, 30)
	$aNums[3] = glf_NewButton($hGui, "3", 220, 240, 30, 30)
	$aNums[4] = glf_NewButton($hGui, "-", 250, 240, 30, 30)
	$aNums[5] = glf_NewButton($hGui, "4", 130, 200, 30, 30)
	$aNums[6] = glf_NewButton($hGui, "5", 170, 200, 30, 30)
	$aNums[7] = glf_NewButton($hGui, "6", 210, 200, 30, 30)
	$aNums[8] = glf_NewButton($hGui, "*", 250, 200, 30, 30)
	$aNums[9] = glf_NewButton($hGui, "7", 130, 160, 30, 30)
	$aNums[10] = glf_NewButton($hGui, "8", 170, 160, 30, 30)
	$aNums[11] = glf_NewButton($hGui, "9", 210, 160, 30, 30)
	$aNums[12] = glf_NewButton($hGui, "/", 250, 160, 30, 30)
	$aNums[13] = glf_NewButton($hGui, ".", 170, 280, 30, 30, BitOR($SS_CENTER, 0, 0))
	$aNums[14] = glf_NewButton($hGui, "+", 260, 280, 30, 30)
	$aNums[15] = glf_NewButton($hGui, "%", 130, 130, 30, 30)
	$aNums[16] = glf_NewButton($hGui, "(", 160, 130, 30, 30)
	$aNums[17] = glf_NewButton($hGui, ")", 200, 130, 30, 30)
	$idEqual = glf_NewButton($hGui, "&=", 220, 280, 30, 30)
	$idClearScreen = glf_NewButton($hGui, "C", 240, 130, 30, 30)
	$idCommandsLb = glf_NewLabel($hGui, Translate($sLang, "&Commands"), 280, 170, 80, 30)
	$idFORMULAS = glf_NewListView($hGui, 10, 110, 90, 149)
	glf_ListViewAddColumns($idFormulas, translate($sLang, "Name|Description|Command"))
	$idOptions = glf_NewButton($hGui, translate($sLang, "&Options"), 40, 260, 60, 70)
	$idGetReason = glf_NewButton($hGui, translate($sLang, "&Reason"), 280, 110, 40, 50)
	$idAbout = glf_NewButton($hGui, translate($sLang, "&About"), 280, 210, 80, 50)
	; we are going to add the information to the list of commands, functions or formulas:
	For $I = 0 To UBound($aInfoFormulas) - 1
		glf_ListViewAddRow($idFORMULAS, Translate($sLang, $aInfoFormulas[$I]) & "|" & $aFlista[$I])
	Next
	; show GUI:
	glf_FormShow($hGui.ptr)
	While 1
		$idMsg = GUIGetMsg()
		Switch $idMsg
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
				_calc($hGUI, $idFORMULAS, $idInter, $idEqual)
			Case $idOptions
				_Options($sConfigFolder, $sConfigPath)
			Case $idGetReason
				_GetReason($idInter, $sOperation)
			Case $idAbout
				MsgBox(48, translate($sLang, "About"), translate($sLang, "An easy, simple and interactive calculator where you can do operations, formulas, conversions and more. This program has been developed by Mateo Cedillo. Creation of the GUI by Valeria Parra."))
			Case $GUI_EVENT_CLOSE, $idMenuExit
				ExitPersonaliced()
		EndSwitch
	WEnd
EndFunc   ;==>Main
Func Generate_task()
EndFunc