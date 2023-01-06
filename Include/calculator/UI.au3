#include <array.au3>
#include <ButtonConstants.au3>
#include "formulas.au3"
#include "globals.au3"
#include <GuiConstantsEx.au3>
#include <ListViewConstants.au3>
#include "params.au3"
#include <StaticConstants.au3>
#include "..\translator.au3"
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
	$idAcciones = GUICtrlCreateMenu("&Calculadora")
	Global $idOcultarKey = GUICtrlCreateMenuItem("Ocultar el teclado" & @TAB & "CTRL+shift+k", $idAcciones)
	GUICtrlSetState(-1, $GUI_Unchecked)
	Local $idMenuExit = GUICtrlCreateMenuItem("Salir", $idAcciones)
	$idEtiquetarInteraccion = GUICtrlCreateLabel("Escribir operación", 10, 10, 160, 90)
	GUICtrlSetColor(-1, 0x000000)
	$idInteraccion = GUICtrlCreateInput("", 170, 0, 220, 110)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Escribe aquí tu operación, luego presiona el botón de igual para obtener el resultado.")
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
	GUICtrlSetTip(-1, "Restar")
	$aNums[5] = GUICtrlCreateButton("4", 130, 200, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[6] = GUICtrlCreateButton("5", 170, 200, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[7] = GUICtrlCreateButton("6", 210, 200, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[8] = GUICtrlCreateButton("*", 250, 200, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Multiplicar")
	$aNums[9] = GUICtrlCreateButton("7", 130, 160, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[10] = GUICtrlCreateButton("8", 170, 160, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[11] = GUICtrlCreateButton("9", 210, 160, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	$aNums[12] = GUICtrlCreateButton("/", 250, 160, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Dividir")
	$aNums[13] = GUICtrlCreateButton(".", 170, 280, 30, 30, BitOR($SS_CENTER, 0, 0))
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Punto (decimal)")
	$aNums[14] = GUICtrlCreateButton("+", 260, 280, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Sumar")
	$aNums[15] = GUICtrlCreateButton("%", 130, 130, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Porcentage")
	$aNums[16] = GUICtrlCreateButton("(", 160, 130, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Abre paréntesis")
	$aNums[17] = GUICtrlCreateButton(")", 200, 130, 30, 30)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Cierra paréntesis")
	$idIgual = GUICtrlCreateButton("&=", 220, 280, 30, 30, BitOR($SS_CENTER, 0, 0))
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Obtiene el resultado de tu operación.")
	$idClearScreen = GUICtrlCreateButton("C", 240, 130, 30, 30)
	GUICtrlSetTip(-1, "Limpia la pantalla.")
	$idEtiquetarLista = GUICtrlCreateLabel("&Comandos", 280, 170, 80, 30)
	GUICtrlSetColor(-1, 0x000000)
	$idFORMULAS = GUICtrlCreateListView("Nombre|Descripción|Comando", 10, 110, 90, 149, $LVS_SORTASCENDING)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Aquí puedes realizar aún más fórmulas que esta calculadora tiene para ofrecerte.")
	$idOpciones = GUICtrlCreateButton("&Opciones", 40, 260, 60, 70)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Configura el programa a tu preferencia.")
	$idMostrarRazon = GUICtrlCreateButton("&Razón", 280, 110, 40, 50, -1)
	GUICtrlSetTip(-1, "Obtiene la razón de por qué esto da igual a lo otro.")
	$idAbout = GUICtrlCreateButton("&Acerca de", 280, 210, 80, 50)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetTip(-1, "Obtener info. sobre el programa.")
	; we are going to add the information to the list of commands, functions or formulas:
	For $I = 0 To UBound($aInfoFormulas) - 1
		GUICtrlCreateListViewItem($aInfoFormulas[$I] & "|" & $aFlista[$I], $idFORMULAS)
	Next
	; setting key accelerators:
	Local $aAccelKeys[][2] = [["^+k", $idOcultarKey], ["^{bs}", $idClearScreen]]
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
			Case $idOcultarKey
				_HideKey($aNums, $idOcultarKey, $bHideKeyboard)
			Case $idClearScreen
				_ClearScreen($idInteraccion)
			Case $idIgual
				_calc()
			Case $idOpciones
				MsgBox(0, "No disponible", "Pronto abrá, pero voy a hacer un to do o ideas: 1, enfocar la pantalla de resultados al realizar una operación o que te la hable el lector directamente. 2, idioma inglés. 3, mostrar automáticamente la razón en una operción en caso de que sean operaciones avanzadas como raíces, potencias etc.")
			Case $idMostrarRazon
				_GetReason()
			Case $idAbout
				MsgBox(48, "Acerca de", "Una calculadora fácil, simple e interactiva donde puedes realizar operaciones, fórmulas, conversiones y más. Este programa ha sido desarrollado por Mateo Cedillo. Creación de la GUI por Valeria Parra.")
			Case $GUI_EVENT_CLOSE, $idMenuExit
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Main