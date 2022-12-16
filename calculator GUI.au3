; Program created by Mateo Cedillo, GUI creation by Valeria Parra feat: AutoBuilder 0.9f Prototype
; Programa creado por Mateo Cedillo, creación de GUI por Valeria Parra feat: AutoBuilder 0.9f Prototype
; set directives for compilation:
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=N
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=This is a mini calculator, but big at same time, because you can do advanced formulas and operations too!
#AutoIt3Wrapper_Res_Description=Universal calculator
#AutoIt3Wrapper_Res_Fileversion=0.1.0.18
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Universal calculator
#AutoIt3Wrapper_Res_ProductVersion=0.1.0.0
#AutoIt3Wrapper_Res_CompanyName=MT Programs
#AutoIt3Wrapper_Res_LegalCopyright=© 2018-2022 MT Programs, All rights reserved
#AutoIt3Wrapper_Res_Language=12298
;#AutoIt3Wrapper_Run_Tidy=y
;#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; include dependencies:
#include <array.au3>
#include <ButtonConstants.au3>
#include <Constants.au3>
#include <EditConstants.au3>
#include "include\mymath\elevar.au3"
#include "include\mymath\fisica.au3"
#include "include\calculator\gui.au3"
#include <GuiButton.au3>
#include <GuiConstantsEx.au3>
#include "include\calculator\keyboard.au3"
#include <ListViewConstants.au3>
#include <Math.au3>
;#include "include\advmathudf-au3\Math.au3"
#include "include\mymath\Progresiones.au3"
#include "include\mymath\raiz.au3"
#include "include\calculator\params.au3"
#include "include\reader.au3"
#include "include\calculator\reasons.au3"
#include "include\advmathudf-au3\Math\Roots.au3"
#include <StaticConstants.au3>
#include <StringConstants.au3>
#include <WindowsConstants.au3>
;Universal calculator (in development):
; setting variables:
Global $sProgramVer = "0.1"
Global $aInteraccion[]
Global $aNumbers[]
Global $sInterOperacion = "", $nResultado = "", $sTipoElevacion = "", $sTipoRaiz = ""
Global $aNums[], $aFormulas[]
Global $bHideKeyboard = False
; help table:
Global $aInfoFormulas[] = ["Radianes a grados|Convierte un número determinado de radianes a grados", "Número máximo|Entre dos números, se verifica cuál es el máximo", "Número mínimo|Entre dos números, se verifica cuál es el menor", "Grados a radianes|Convierte un número determinado de grados a radianes", "Aceleración|Optiene la aceleración de una velocidad y un tiempo", "arcocoseno|Calcula el arcocoseno de una expresión", "Arcoseno|Calcula el arcoseno de una expresión", "Arcotangente|Calcula el arcotangente de una expresión", "Coseno|Calcula el coseno de una expresión", "distancia|Optiene la distancia de una velocidad o tiempo determinados", "Logaritmo|Calcula el logaritmo de una expresión", "redondear|Redondea un número decimal al más cercano posible", "Seno|Calcula el seno de una expresión", "tangente|Calcula la tangente de una expresión", "Progresión aritmética: a1|Obtiene el primer término", "Progresión geométrica: a1|Obtiene el primer término de una progresión geométrica", "Progresión aritmética: d|Obtiene la diferencia", "Progresión geométrica: R|Obtiene la razón", "Progresión aritmética: n|Obtiene el número de término", "Progresión geométrica: N|Obtiene el número de término", "Progresión aritmética: AN|Obtiene el término enésimo", "Progresión geométrica: an|Obtiene el término enésimo", "Progresión aritmética: SN1|Este es el primer método que suma los términos", "Progresión geométrica: sn1|Primer método que suma los términos", "Elevar|Potencia, ej: 3 elevado a la 8", "Raíz|Aplica una raíz cualquiera de un número, ej: Raíz cuarta de 1024", "Raíz cuadrada|Aplica la raíz cuadrada de un número determinado", "raíz cúbica|Aplica la raíz cúbica de un número determinado", "Tiempo|Optiene el tiempo de una velocidad y distancia definidos", "Velocidad|Optiene la velocidad de una distancia y un tiempo determinados"]
Global $aFlista = _SearchParam(Null, Default, True)
_ArrayColDelete($aFlista, 1, True)
Global $hGUI, $idInteraccion, $idClearScreen, $idFORMULAS, $idOpciones, $idRazon, $idEtiquetaInput, $idEtiquetarLista, $idAbout, $idIgual, $idMSG
; We call the main function of the program:
Main()
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
	;$idClearScreen = _GUICtrlButton_Create($hGUI, "C", 240, 130, 30, 30, BitOR($BS_COMMANDLINK, $BS_DEFCOMMANDLINK))
	;_GUICtrlButton_SetNote($idClearScreen, "CTRL+BackSpace")
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
				MsgBox(48, "Acerca de universal calculator", "Una calculadora fácil, simple e interactiva donde puedes realizar operaciones, fórmulas, conversiones y más. Este programa ha sido desarrollado por Mateo Cedillo. Creación de la GUI por Valeria Parra.")
			Case $GUI_EVENT_CLOSE, $idMenuExit
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Main
; #FUNCTION# ====================================================================================================================
; Name ..........: _calc
; Description ...:
; Syntax ........: _calc()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _calc()
	$sInterOperacion = GUICtrlRead($idInteraccion)
	If $sInterOperacion = "" And Not _IsFocused($hGUI, $idFORMULAS) Then
		MsgBox(16, "Error", "Debes escribir una operación o seleccionar un comando.")
	ElseIf _IsFocused($hGUI, $idFORMULAS) Then
		; if we have focused the control in the list of commands, what to do:
		$sInterOperacion = CreateParams($idFORMULAS)
		If @error Then
			Switch @error
				Case 1
					MsgBox(16, "Error", "La lista no requiere con las columnas necesarias para interactuar.")
				Case 2
					MsgBox(16, "Error", "No has seleccionado ninguna fórmula de la lista.")
				Case 3
					MsgBox(16, "Error", "La tabla de parámetros especificada es incorrecta.")
				Case 4
					MsgBox(16, "Error", "Se ha tratado de buscar esta fórmula en la tabla de fórmulas, sin envargo, no se encuentra.")
				Case 5
					MsgBox(16, "Error", "La ventana de aplicación de esta fórmula se ha cerrado y esta no ha podido ser aplicada.")
				Case 6
					MsgBox(16, "Error", "Debes rellenar todos los parámetros para proceder a aplicar esta fórmula. Por ahora, esta función no se ha aplicado.")
			EndSwitch
		Else
			; Adds the command in the field, if it is not focused it does so and clicks the same button automatically to get the result.
			GUICtrlSetData($idInteraccion, $sInterOperacion)
			If Not _IsFocused($hGUI, $idInteraccion) Then GUICtrlSetState($idInteraccion, $GUI_Focus)
			_GUICtrlButton_Click($idIgual)
		EndIf
	Else
		; If the user has written an operation with the decimal comma, replace it with point.
		If StringInStr($sInterOperacion, ",") Then $sInterOperacion = StringReplace($sInterOperacion, ",", ".")
		; Now we check if a command has been typed. The key sign for this is the ":" (colon) sign.
		If Not StringInStr($sInterOperacion, ":") Then
			$nResultado = Execute($sInterOperacion)
			If @error Then
				MsgBox(16, "Error", "Ocurrió un error al realizar esta operación. Por favor, mira que la sintaxis esté correcta.")
			Else
				GUICtrlSetData($idInteraccion, $nResultado)
				If Not _IsFocused($hGUI, $idInteraccion) Then GUICtrlSetState($idInteraccion, $GUI_Focus)
			EndIf
		Else
			$aInteraccion = StringSplit($sInterOperacion, ":")
			$aNumbers = StringSplit($aInteraccion[2], " ")
			; convert strings to numbers, which is what it has to be in reality:
			For $I = 1 To $aNumbers[0]
				$aNumbers[$I] = Number($aNumbers[$I])
			Next
			; We make support for commands or formulas available:
			Select
				Case $aInteraccion[1] = "deg"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = _Degree($aNumbers[1])
						GUICtrlSetData($idInteraccion, "°" & $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Error al convertir los radianes a grados. Asegúrate de que escribiste bien el parámetro, el número de radianes: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay más de un parámetro aquí. Para esta conversión necesitas solamente el número de radianes a convertir. Por favor, dale una rebisada: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "max"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Max($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No se ha podido obtener el valor máximo, ya que falta un elemento. Por favor, revise atentamente y vuelva a intentar: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Tienes demás parámetros, recuerda que necesitas solo dos, un número menor y otro mayor para hacer esto. Por favor, verifica: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "min"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Min($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta un parámetro para poder sacar el valor mínimo. Por favor, revisa: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "No se puede sacar el valor mínimo porque tienes demás de los parámetros permitidos en esta función. Revisa y elimina el o los parámetros de sobra si es necesario: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "rad"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = _Radian($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Error de conversión de Grados a Radianes. Revisa bien que tengas el único parámetro, que es el número de grados para convertir a radianes. Revisa lo siguiente: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Tienes dos o más parámetros, por lo que no hace falta. Asegúrate de que tienes solamente el número de grados: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "acc"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _aceleracion($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Fíjate que no falte la velocidad o el tiempo: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Los parámetros son demás. Por favor, revisa: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "acos"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = ACos($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No se puede calcular el arcocoseno porque no tienes el parámetro requerido: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Para hacer el cálculo del arcocoseno solo necesitamos el número (o la expresión): " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "asin"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = ASin($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No es posible calcular el arcoseno de este número (expresión) porque falta el parámetro requerido: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Error al realizar el cálculo del arcoseno porque tienes demás parámetros. Asegúrate de que escribiste bien la expresión (sin espacios): " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "atan"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = ATan($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta el parámetro que corresponde al número o expresión para obtener el cálculo del arcotangente: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Tienes demás parámetros. Necesitamos tan solo un número o una expresión para calcular el arcotangente: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "cos"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Cos($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Error al calcular el coseno porque falta el parámetro que contiene el número (o expresión) ¿Podrías revisarlo, por favor?: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Tienes dos o más parámetros, por lo que para calcular el coseno necesitamos un número o una expresión: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "dox"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _D_o_X($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "por favor, revisa que no falta la velocidad o el tiempo: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay parámetros de sobra. Necesitamos oslo la velocidad y el tiempo: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "log"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Log($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta el número o la expresión requerida para calcular el logaritmo: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay demás parámetros. Recuerda que solo necesitas un parámetro que es un número o una expresión, para calcular el logaritmo natural: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ro"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Round($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Necesitas el número a redondear para realizar esta función. Por favor revisa y, luego, vuelve a intentar con el comando ya corregido: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay demás parámetros para esta función. Solo necesitas el número para redondear. Por favor, revisa: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "sin"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Sin($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No se puede obtener el seno porque falta el número o la expresión: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "NO necesitas otro parámetro más que el valor para aplicar el seno: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "tan"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Tan($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No se puede calcular la tangente porque falta número o expresión para que esto sea aplicado: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay dos o más parámetros, por lo que solamente necesitas un número o una expresión: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-a1"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _a1($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se puede obtener el término porque faltan elementos. Por favor, rebisa: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-a1"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _a12($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se puede obtener el término porque faltan elementos. Por favor, rebisa: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-d"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _Diference($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se ha podido obtener la diferencia, porque falta(n) elemento(s) necesarios para esta fórmula. Rebisa por favor: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-r"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _r($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se ha podido obtener la razón, porque falta(n) elemento(s) necesarios para esta fórmula. Rebisa por favor: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-n"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _NumTerm($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se puede obtener el número de término porque falta(n) elemento(s) necesarios. Por favor, haz una rebisión y trata de corregir: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-n"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _NumTerm2($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se puede obtener el número de término porque falta(n) elemento(s) necesarios. Por favor, haz una rebisión y trata de corregir: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-an"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _AN($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se puede obtener el término enpesimo porque falta(n) elemento(s) que son necesarios para la fórmula. Considera hacer una rebisión: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-an"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _AN2($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se puede obtener el término enpesimo porque falta(n) elemento(s) que son necesarios para la fórmula. Considera hacer una rebisión: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-sn1"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _Sn1($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se ha podido obtener la suma de términos porque falta(n) elemento(s). Por favor, rebisa e intenta realizar esta operación con los elementos completos de esta fórmula: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-sn1"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Sn3($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se ha podido obtener la suma de términos porque falta(n) elemento(s). Por favor, rebisa e intenta realizar esta operación con los elementos completos de esta fórmula: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "raise"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Elevado($aNumbers[1], $aNumbers[2])
						Switch $aNumbers[2]
							Case 2
								$sTipoElevacion = "cuadrado"
							Case 3
								$sTipoElevacion = "cubo"
							Case 4
								$sTipoElevacion = "cuarto"
							Case 5
								$sTipoElevacion = "quinto"
							Case 6
								$sTipoElevacion = "sexto"
							Case 7
								$sTipoElevacion = "septimo"
							Case 8
								$sTipoElevacion = "octavo"
							Case 9
								$sTipoElevacion = "noveno"
						EndSwitch
						;GUICtrlSetData($idPantallaResultados, $aNumbers[1] & " elevado al " & $sTipoElevacion & " es igual a: " & $nResultado)
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de elevación", "No se puede realizar esta operación porque falta el número base o el exponente. Por favor, comprueba e intenta de nuevo: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de elevación", "Tienes demás elementos para resolver esto. Por favor, ajusta bien los parámetros de esta fórmula.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "root"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Raiz2($aNumbers[1], $aNumbers[2])
						Switch $aNumbers[1]
							Case 2
								$sTipoRaiz = "cuadrada"
							Case 3
								$sTipoRaiz = "cúbica"
							Case 4
								$sTipoRaiz = "cuarta"
							Case 5
								$sTipoRaiz = "quinta"
							Case 6
								$sTipoRaiz = "sexta"
							Case 7
								$sTipoRaiz = "Séptima"
							Case 8
								$sTipoRaiz = "octaba"
							Case 9
								$sTipoRaiz = "novena"
						EndSwitch
						;GUICtrlSetData($idPantallaResultados, "La raíz " & $sTipoRaiz & " de " & $aNumbers[2] & ", es igual a: " & $nResultado)
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de raíz", "No se puede realizar esta raíz ya que falta uno de los parámetros. Por favor, considera revisar esto: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de raíz", "Sobran parámetros aquí. Rebisa que no estén más de estos dos parámetros, el número de raíz y el número para obtenerla, ej: raiz:3 4 saca raíz cúbica de 4.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "sr"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Sqrt($aNumbers[1])
						;GUICtrlSetData($idPantallaResultados, "La raíz cuadrada de " & $aNumbers[1] & ", es igual a: " & $nResultado)
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de raíz", "No se puede realizar esta raíz ya que falta uno de los parámetros. Por favor, considera revisar esto: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de raíz", "Sobran parámetros aquí. Rebisa que no estén más de estos dos parámetros, el número de raíz y el número para obtenerla, ej: raiz:3 4 saca raíz cúbica de 4.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "cr"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = cbrt($aNumbers[1])
						;GUICtrlSetData($idPantallaResultados, "La raíz cúbica de " & $aNumbers[1] & ", es igual a: " & $nResultado)
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de raíz", "No se puede realizar la raíz cúbica ya que falta uno de los parámetros. Por favor, considera revisar esto: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de raíz", "Sobran parámetros aquí. Recuerda que solo deberás introducir un parámetro, el número con el que hacer la raíz.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "time"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _tiempo($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta la velocidad o la distancia. Por fafor, corrije: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay parámetros de sobra aquí, no necesitas más que la velocidad y la distancia: " &$sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "vel"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Velocidad($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta la distancia o el tiempo. Esta es la operación original para que la revises: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Necesitas solamente la distancia y el tiempo para aplicar esta fórmula, pues tienes parámetros que sobran: " &$sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case Else
					MsgBox(16, "Error", "El comando " & $aInteraccion[1] & " no existe. Si crees que es una función que permita realizar una fórmula matemática, por favor dime para poder agregarla.")
			EndSelect
			GUICtrlSetState($idInteraccion, $GUI_Focus)
		EndIf
	EndIf
EndFunc   ;==>_calc