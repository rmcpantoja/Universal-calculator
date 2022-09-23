#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Comment=This is a mini calculator, but big at same time, because you can do advanced formulas and operations too!
#AutoIt3Wrapper_Res_Description=Universal calculator
#AutoIt3Wrapper_Res_Fileversion=0.1.0.4
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Universal calculator
#AutoIt3Wrapper_Res_ProductVersion=0.1.0.0
#AutoIt3Wrapper_Res_CompanyName=MT Programs
#AutoIt3Wrapper_Res_Language=12298
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <EditConstants.au3>
#include "include\elevar.au3"
#include <GuiConstantsEx.au3>
#include <Math.au3>
#include "include\Progresiones.au3"
#include "include\raiz.au3"
#include "include\reader.au3"
#include <WindowsConstants.au3>
;Universal calculator (in development):
Global $sProgramVer = "0.1"
Local $aInteraccion[]
Global $aNumbers[]
$sInterOperacion = ""
$nResultado = ""
$sTipoElevacion = ""
$sTipoRaiz = ""
Main()
Func Main()
	; Creating GUI and its controls:
	;Note! No GUI acceleration is guaranteed for now, because I'm using the default and common message loop that everyone uses. In fact, I have already reported this in the NVDA code. Maybe a solution will be found: https://github.com/nvaccess/nvda/issues/13833
	$hGui = GUICreate("Universal calculator " & $sProgramVer, 600, 600)
	$idClearScreen = GUICtrlCreateButton("Limpiar la pantalla", 10, 10, 100, 20)
	$idOpciones = GUICtrlCreateButton("Opciones", 10, 90, 100, 20)
	$idEtiquetarInteraccion = GUICtrlCreateLabel("Escribe aquí operación o acción", 90, 10, 100, 20)
	$idInteraccion = GUICtrlCreateInput("", 90, 90, 100, 20)
	GUICtrlSetState(-1, $GUI_Focus)
	$idIgual = GUICtrlCreateButton("&=", 90, 170, 200, 20)
	$idMostrarRazon = GUICtrlCreateButton("Mostrar razón (por qué)", 90, 250, 100, 20)
	$idEtiquetarPantalla = GUICtrlCreateLabel("Pantalla de resultados", 170, 125, 200, 20)
	$idPantallaResultados = GUICtrlCreateEdit("", 170, 205, 400, 50, BitOR($ES_READONLY, $ES_RIGHT), $WS_EX_STATICEDGE)
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $idClearScreen
				If GUICtrlRead($idInteraccion) = "" Then
					Speaking("No hay nada que limpiar")
				Else
					GUICtrlSetData($idInteraccion, "")
					$sInterOperacion = ""
					$nResultado = ""
					speaking("Pantalla limpia")
				EndIf
			Case $idIgual
				$sInterOperacion = GUICtrlRead($idInteraccion)
				If $sInterOperacion = "" Then
					MsgBox(16, "Error", "Debes escribir una operación o comando.")
				Else
					; If the user has written an operation with the decimal comma, replace it with point.
					If StringInStr($sInterOperacion, ",") then $sInterOperacion = StringReplace($sInterOperacion, ",", ".")
					; Now we check if a command has been typed. The key sign for this is the ":" (colon) sign.
					If Not StringInStr($sInterOperacion, ":") Then
						$nResultado = Execute($sInterOperacion)
						If @error Then
							MsgBox(0, "Error", "Ocurrió un error al realizar esta operación. Por favor, mira que la sintaxis esté correcta.")
						Else
							GUICtrlSetData($idPantallaResultados, $sInterOperacion & " " &"igual a: " & $nResultado)
							GUICtrlSetState($idPantallaResultados, $GUI_Focus)
						EndIf
					Else
						$aInteraccion = StringSplit($sInterOperacion, ":")
						$aNumbers = StringSplit($aInteraccion[2], " ")
						; convert strings to numbers, which is what it has to be in reality:
						For $I = 1 to $aNumbers[0]
							$aNumbers[$I] = Number($aNumbers[$I])
						Next
						; We make support for commands or formulas available:
						Select
							Case $aInteraccion[1] = "deg"
								If _CheckComandParams(1) Then
									$nResultado = _Degree($aNumbers[1])
									GUICtrlSetData($idPantallaResultados, "el resultado de radianes a grados es: °" & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error", "Error al convertir los radianes a grados. Asegúrate de que escribiste bien el parámetro, el número de radianes: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error", "Hay más de un parámetro aquí. Para esta conversión necesitas solamente el número de radianes a convertir. Por favor, dale una rebisada: " & $sInterOperacion)
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "max"

							Case $aInteraccion[1] = "min"

							Case $aInteraccion[1] = "rad"

							Case $aInteraccion[1] = "arcocoseno"

							Case $aInteraccion[1] = "arcoseno"

							Case $aInteraccion[1] = "arcotan"

							Case $aInteraccion[1] = "coseno"

							Case $aInteraccion[1] = "logaritmo"

							Case $aInteraccion[1] = "redondeo"

							Case $aInteraccion[1] = "seno"

							Case $aInteraccion[1] = "tan"

							Case $aInteraccion[1] = "ap-a1"
								If _CheckComandParams(3) Then
									$nResultado = _a1($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "El primer término es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión aritmética", "No se puede obtener el término porque faltan elementos. Por favor, rebisa: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "gp-a1"
								If _CheckComandParams(3) Then
									$nResultado = _a12($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "El primer término es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión geométrica", "No se puede obtener el término porque faltan elementos. Por favor, rebisa: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "ap-dif"
								If _CheckComandParams(3) Then
									$nResultado = _Diference($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "La diferencia es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión aritmética", "No se ha podido obtener la diferencia, porque falta(n) elemento(s) necesarios para esta fórmula. Rebisa por favor: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "gp-r"
								If _CheckComandParams(3) Then
									$nResultado = _r($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "La razón es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión geométrica", "No se ha podido obtener la razón, porque falta(n) elemento(s) necesarios para esta fórmula. Rebisa por favor: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "ap-n"
								If _CheckComandParams(3) Then
									$nResultado = _NumTerm($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "El número de término es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión aritmética", "No se puede obtener el número de término porque falta(n) elemento(s) necesarios. Por favor, haz una rebisión y trata de corregir: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "gp-n"
								If _CheckComandParams(3) Then
									$nResultado = _NumTerm2($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "El número de término es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión geométrica", "No se puede obtener el número de término porque falta(n) elemento(s) necesarios. Por favor, haz una rebisión y trata de corregir: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "ap-an"
								If _CheckComandParams(3) Then
									$nResultado = _AN($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "El término enésimo es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión aritmética", "No se puede obtener el término enpesimo porque falta(n) elemento(s) que son necesarios para la fórmula. Considera hacer una rebisión: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "gp-an"
								If _CheckComandParams(3) Then
									$nResultado = _AN2($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "El término enésimo es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión geométrica", "No se puede obtener el término enpesimo porque falta(n) elemento(s) que son necesarios para la fórmula. Considera hacer una rebisión: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "ap-sn1"
								If _CheckComandParams(3) Then
									$nResultado = _Sn1($aNumbers[1], $aNumbers[2], $aNumbers[3])
									GUICtrlSetData($idPantallaResultados, "La suma de los términos es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión aritmética", "No se ha podido obtener la suma de términos porque falta(n) elemento(s). Por favor, rebisa e intenta realizar esta operación con los elementos completos de esta fórmula: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "gp-sn1"
								If _CheckComandParams(2) Then
									$nResultado = _Sn3($aNumbers[1], $aNumbers[2])
									GUICtrlSetData($idPantallaResultados, "La suma de los términos es: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de progresión geométrica", "No se ha podido obtener la suma de términos porque falta(n) elemento(s). Por favor, rebisa e intenta realizar esta operación con los elementos completos de esta fórmula: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "elevar"
								If _CheckComandParams(2) Then
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
									GUICtrlSetData($idPantallaResultados, $aNumbers[1] & " elevado al " & $sTipoElevacion & " es igual a: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de elevación", "No se puede realizar esta operación porque falta el número base o el exponente. Por favor, comprueba e intenta de nuevo: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de elevación", "Tienes demás elementos para resolver esto. Por favor, ajusta bien los parámetros de esta fórmula.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "raiz"
								If _CheckComandParams(2) Then
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
									GUICtrlSetData($idPantallaResultados, "La raíz " & $sTipoRaiz & " de " & $aNumbers[2] & ", es igual a: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de raíz", "No se puede realizar esta raíz ya que falta uno de los parámetros. Por favor, considera revisar esto: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de raíz", "Sobran parámetros aquí. Rebisa que no estén más de estos dos parámetros, el número de raíz y el número para obtenerla, ej: raiz:3 4 saca raíz cúbica de 4.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case $aInteraccion[1] = "sr"
								If _CheckComandParams(1) Then
									$nResultado = Sqrt($aNumbers[1])
									GUICtrlSetData($idPantallaResultados, "La raíz cuadrada de " & $aNumbers[1] & ", es igual a: " & $nResultado)
								ElseIf @error = 1 Then
									MsgBox(16, "Error de raíz", "No se puede realizar esta raíz ya que falta uno de los parámetros. Por favor, considera revisar esto: " & $sInterOperacion)
								ElseIf @error = 2 Then
									MsgBox(16, "Error de raíz", "Sobran parámetros aquí. Rebisa que no estén más de estos dos parámetros, el número de raíz y el número para obtenerla, ej: raiz:3 4 saca raíz cúbica de 4.")
								ElseIf @error = 3 Then
									MsgBox(16, "Error de sintaxis", "El parámetro " &@extended &", " &$aNumbers[@extended] &", no tiene números.")
								EndIf
							Case Else
								MsgBox(16, "Error", "El comando " & $aInteraccion[1] & " no existe. Si crees que es una función que permita realizar una fórmula matemática, por favor dime para poder agregarla.")
						EndSelect
						GUICtrlSetState($idPantallaResultados, $GUI_Focus)
					EndIf
				EndIf
			Case $idOpciones
				MsgBox(0, "No disponible", "Pronto abrá, pero voy a hacer un to do o ideas: 1, enfocar la pantalla de resultados al realizar una operación o que te la hable el lector directamente. 2, idioma inglés. 3, mostrar automáticamente la razón en una operción en caso de que sean operaciones avanzadas como raíces, potencias etc.")
			Case $idMostrarRazon
				;ToDo: Reducir el código haciendo una matriz de los números ordinales en vez del switch que los contiene, y hacer un for. Durante ese ciclo for, se comprueba: si ese número está en los parámetros donde se muestren con números ordinales, se establece, o en $sTipoElevacion o en $sTipoRaiz. Pero sí, para reducir código será una sola matriz con los números ordinales que se manipulará en una operación x. Si se necesitan solo femeninas, será solo una matriz 1d, pero si se necesitan masculinas entonces toca hacer una matriz 2d. Yay, qué difícil soy. Pero mejora mucho el rendimiento y el código ¿Eh?
				;ToDo #2: agregar más números ordinales. Décimo, onceabo, doceabo...
				If GUICtrlRead($idInteraccion) = "" Then
					MsgBox(16, "Error", "Debes escribir un comando de función que realice una operación para obtener una razón.")
				ElseIf $sInterOperacion = "" Then
					MsgBox(16, "Error", "Debes primero conseguir el resultado de " & GUICtrlRead($idInteraccion) & ", para poder obtener la razón de este.")
				Else
					Switch $aInteraccion[1]
						Case "elevar"
							$aProceso = _Elevado($aNumbers[1], $aNumbers[2], True)
							$aProceso[0] = StringReplace($aProceso[1], "*", " por ")
							$aProceso[0] = StringReplace($aProceso[1], "=", " igual a ")
							MsgBox(0, "Razón", "La razón de por qué " & GUICtrlRead($idPantallaResultados) & ", es porque " & $aProceso[0])
						Case "raiz"
							$aProceso = RaizObtenerRazon2($nResultado, $aNumbers[1])
							$aProceso[0] = StringReplace($aProceso[0], "*", " para ")
							MsgBox(0, "Razónn", "El motivo de por qué " & GUICtrlRead($idPantallaResultados) & ", se debe a que " & $aProceso[0] & " es igual a: " & $aProceso[1])
							;Vamos a comentar esto, porque trae problemas. EN realidad, la razón para sr está deshabilitada porque está comentada, hasta que encontremos una solución para poder obtener correctamente las razones.
							;case "sr"
							;$aProceso = RaizObtenerRazon2(2, $aNumbers[1])
							;$aProceso[0] = StringReplace($aProceso[0], "*", " para ")
							;Fixes / correcciones:
							;$aProceso[0] &= "/2"
							;$aProceso[1] = $aProceso[1] /2
							;MsgBox(0, "Razón", "Esto es fácil, pero aquí la tienes: " &GuiCtrlRead($idPantallaResultados) &" es porque " &$aProceso[0] &" es igual a " &$aProceso[1])
						Case Else
							MsgBox(16, "Error", "No se puede obtener la razón para " & $aInteraccion[1] & " aquí. Este comando no está soportado como para poder obtener una razón. Si crees que hay una alternativa, por favor dímelo.")
					EndSwitch
				EndIf
			Case -3
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Main
Func _CheckComandParams($nParams)
	;ToDo: Si es verdadero, bien, seguir con true. Pero si es falso, retornar @error en. 1 si el número de parámetros que se estableció es menor al establecido, y 2 si en cambio es mayor. Hecho.
	If $aNumbers[0] = $nParams Then
		Return True
	ElseIf $aNumbers[0] < $nParams Then
		SetError(1, 0, "The num params is minor tan established param.")
	ElseIf $aNumbers[0] > $nParams Then
		SetError(2, 0, "The num params is major tan established param.")
	Else
	For $I = 1 to $aNumbers[0]
		If not IsNumber($aNumbers[$I]) then return SetError(3, $I, "Parameter " &$I &", " &$aNumbers[$I] &", is not a number.")
	Next
	EndIf
EndFunc   ;==>_CheckComandParams
