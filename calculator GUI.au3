#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Comment=This is a mini calculator, but big at same time, because you can do advanced formulas and operations too!
#AutoIt3Wrapper_Res_Description=Universal calculator
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Universal calculator
#AutoIt3Wrapper_Res_ProductVersion=0.1.0.0
#AutoIt3Wrapper_Res_CompanyName=MT Programs
#AutoIt3Wrapper_Res_Language=12298
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <EditConstants.au3>
#include "include\elevar.au3"
#include "include\funciones aritmeticas.au3"
#include <GuiConstantsEx.au3>
#include <Math.au3>
#include "include\raiz.au3"
#include "include\reader.au3"
#include <WindowsConstants.au3>
Local $aInteraccion[]
global $aNumbers[]
$sInterOperacion = ""
$nResultado = ""
$sTipoElevacion = ""
Main()
Func Main()
$hGui = GuiCreate("Calculador misceláneo, por mateo C", 600, 600)
$idClearScreen = GuiCtrlCreateButton("Limpiar la pantalla", 10, 10, 100, 20)
$idOpciones = GuiCtrlCreateButton("Opciones", 10, 80, 100, 20)
$idEtiquetarInteraccion = GuiCtrlCreateLabel("Escribe aquí operación o acción", 80, 10, 100, 20)
$idInteraccion = GuiCtrlCreateInput("", 80, 80, 100, 20)
GUICtrlSetState(-1, $GUI_Focus)
$idIgual = GuiCtrlCreateButton("&=", 80, 80, 500, 20)
$idMostrarRazon = GuiCtrlCreateButton("Mostrar razón (por qué)", 80, 220, 100, 20)
$idEtiquetarPantalla = GuiCtrlCreateLabel("Pantalla de resultados", 160, 75, 200, 20)
$idPantallaResultados = GUICtrlCreateEdit("", 160, 145, 400, 50, BitOR($ES_READONLY, $ES_RIGHT), $WS_EX_STATICEDGE)
GuiSetState(@sw_SHOW)
While 1
Switch GuiGetMsg()
Case $idClearScreen
If GuiCtrlRead($idInteraccion) = "" then
Speaking("No hay nada que limpiar")
Else
GuiCtrlSetData($idInteraccion, "")
$sInterOperacion = ""
$nResultado = ""
speaking("Pantalla limpia")
EndIf
case $idIgual
$sInterOperacion = GuiCtrlRead($idInteraccion)
If $sInterOperacion = "" then
MsgBox(16, "Error", "Debes escribir una operación o comando.")
Else
If Not StringInStr($sInterOperacion, ":") then
$nResultado = Execute($sInterOperacion)
if @error then
MsgBox(0, "Error", "Ocurrió un error al realizar esta operación. Por favor, mira que la sintaxis esté correcta.")
Else
GuiCtrlSetData($idPantallaResultados, $sInterOperacion &"igual a: " &$nResultado)
GUICtrlSetState($idPantallaResultados, $GUI_Focus)
EndIf
Else
$aInteraccion = StringSplit($sInterOperacion, ":")
$aNumbers = StringSplit($aInteraccion[2], " ")
Select
case $aInteraccion[1] = "deg"
If _CheckComandParams(1) then
Else
MsgBox(16, "Error", "Error al convertir los radianes: " &$sInterOperacion)
EndIf
case $aInteraccion[1] = "max"

case $aInteraccion[1] = "min"

case $aInteraccion[1] = "rad"

case $aInteraccion[1] = "arcocoseno"

case $aInteraccion[1] = "arcoseno"

case $aInteraccion[1] = "arcotan"

case $aInteraccion[1] = "coseno"

case $aInteraccion[1] = "logaritmo"

case $aInteraccion[1] = "redondeo"

case $aInteraccion[1] = "seno"

case $aInteraccion[1] = "tan"

case $aInteraccion[1] = "a1"
If _CheckComandParams(3) then
$nResultado = _a1($aNumbers[1], $aNumbers[2], $aNumbers[3])
GuiCtrlSetData($idPantallaResultados, "El primer término es: " &$nResultado)
Else
MsgBox(16, "Error de progresión aritmética", "No se puede obtener el término porque faltan elementos. Por favor, rebisa: " &$sInterOperacion)
EndIf
case $aInteraccion[1] = "Diferencia"
If _CheckComandParams(3) then
$nResultado = _Diference($aNumbers[1], $aNumbers[2], $aNumbers[3])
GuiCtrlSetData($idPantallaResultados, "La diferencia es: " &$nResultado)
Else
MsgBox(16, "Error de progresión aritmética", "No se ha podido obtener la diferencia, porque falta(n) elemento(s) necesarios para esta fórmula. Rebisa por favor: " &$sInterOperacion)
EndIf
case $aInteraccion[1] = "NumTerm"
If _CheckComandParams(3) then
$nResultado = _NumTerm($aNumbers[1], $aNumbers[2], $aNumbers[3])
GuiCtrlSetData($idPantallaResultados, "El número de término es: " &$nResultado)
Else
MsgBox(16, "Error de progresión aritmética", "No se puede obtener el número de tpermino porque falta(n) elemento(s) necesarios. Por favor, haz una rebisión y trata de corregir: " &$sInterOperacion)
EndIf
case $aInteraccion[1] = "An"
If _CheckComandParams(3) then
$nResultado = _AN($aNumbers[1], $aNumbers[2], $aNumbers[3])
GuiCtrlSetData($idPantallaResultados, "El término enésimo es: " &$nResultado)
Else
MsgBox(16, "Error de progresión aritmética", "No se puede obtener el término enpesimo porque falta(n) elemento(s) que son necesarios para la fórmula. Considera hacer una rebisión: " &$sInterOperacion)
EndIf
case $aInteraccion[1] = "sn1"
If _CheckComandParams(3) then
$nResultado = _Sn1($aNumbers[1], $aNumbers[2], $aNumbers[3])
GuiCtrlSetData($idPantallaResultados, "La suma de los términos es: " &$nResultado)
Else
MsgBox(16, "Error de progresión aritmética", "No se ha podido obtener la suma de términos porque falta(n) elemento(s). Por favor, rebisa e intenta realizar esta operación con los elementos completos de esta fórmula: " &$sInterOperacion)
EndIf
case $aInteraccion[1] = "elevar"
If _CheckComandParams(2) then
$nResultado = _Elevado($aNumbers[1], $aNumbers[2])
switch $aNumbers[2]
case 2
$sTipoElevacion = "cuadrado"
case 3
$sTipoElevacion = "cubo"
case 4
$sTipoElevacion = "cuarto"
case 5
$sTipoElevacion = "quinto"
case 6
$sTipoElevacion = "sexto"
case 7
$sTipoElevacion = "septimo"
case 8
$sTipoElevacion = "octavo"
case 9
$sTipoElevacion = "noveno"
EndSwitch
GuiCtrlSetData($idPantallaResultados, $aNumbers[1] &" elevado al " &$sTipoElevacion &" es igual a: " &$nResultado)
Else
MsgBox(16, "Error de elevación", "No se puede realizar esta operación porque falta el número base o el exponente. Por favor, comprueba e intenta de nuevo: " &$sInterOperacion)
EndIf
Case else
MsgBox(16, "Error", "El comando " &$aInteraccion[1] &" no existe. Si crees que es una función que permita realizar una fórmula matemática, por favor dime para poder agregarla.")
EndSelect
GUICtrlSetState($idPantallaResultados, $GUI_Focus)
EndIf
EndIf
case $idOpciones
MsgBox(0, "No disponible", "Pronto abrá, pero voy a hacer un to do o ideas: 1, enfocar la pantalla de resultados al realizar una operación o que te la hable el lector directamente. 2, idioma inglés. 3, mostrar automáticamente la razón en una operción en caso de que sean operaciones avanzadas como raíces, potencias etc.")
case $idMostrarRazon
If GuiCtrlRead($idInteraccion) = "" then
MsgBox(16, "Error", "Debes escribir un comando de función que realice una operación para obtener una razón.")
Elseif $sInterOperacion = "" then
MsgBox(16, "Error", "Debes primero conseguir el resultado de " &GuiCtrlRead($idInteraccion) &", para poder obtener la razón de este.")
Else
Switch $aInteraccion[1]
Case "elevar"
$aProceso = _Elevado($aNumbers[1], $aNumbers[2], true)
$aProceso[1] = StringReplace($aProceso[1], "*", "Por")
$aProceso[1] = StringReplace($aProceso[1], "=", "igual a")
MsgBox(0, "Razón", "La razón de por qué " &GuiCtrlRead($idPantallaResultados) &", es porque " &$aProceso[1])
Case Else
MsgBox(16, "Error", "No se puede obtener la razón para " &$aInteraccion[1] &" aquí. Este comando no está soportado como para poder obtener una razón. Si crees que hay una alternativa, por favor dímelo.")
EndSwitch
EndIf
case -3
ExitLoop
EndSwitch
WEnd
EndFunc
Func _CheckComandParams($nParams)
;ToDo: Si es verdadero, bien, seguir con true. Pero si es falso, retornar @error en. 1 si el número de parámetros que se estableció es menor al establecido, y 2 si en cambio es mayor.
Return $aNumbers[0] = $nParams
EndFunc