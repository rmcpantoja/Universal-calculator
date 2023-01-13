#include "..\Include\mymath\Task_creator.au3"
; llamamos a la función principal:
Main()
; #FUNCTION# ====================================================================================================================
; Name ..........: Main
; Description ...: Función principal para este pequeño programa, pero que hace una gran función.
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
	; declarando variables:
	Local $aTarea, $aOperadores
	Local $bPlural = False
	Local $hFile
	Local $nNivel
	Local $sDeCadaUno = ""
	Local $vMiOperacion = ""
	$nNivel = Number(InputBox("Nivel", "¿De qué nivel quieres esta tarea? (1 a 3)"))
	; qué hacer si el usuario no escribe nada o cancela la operación:
	If @error Then
		MsgBox(16, "Error", "Debes escribir el nivel para proceder")
		Exit
	EndIf
	; ejecutamos la función _CrearTarea (la veremos más adelante)
	$aTarea = _CrearTarea($nNivel)
	; en caso de error...
	If @error Then
		MsgBox(16, "Error al realizar la tarea", @error)
		Exit
	EndIf
	; identificar qué operaciones hay y de qué tipos son:
	$aOperadores = _count_homework_Operators($aTarea)
	; crear una cadena, en su contenido almacenaremos un pequeño resumen de los tipos de operaciones y todo lo que hay en la tarea.
	$sDeCadaUno &= UBound($aTarea) & " diferentes operaciones en total. En esta tarea te he dado " & UBound($aOperadores, 1) & " tipos que son: "
	; creamos un bucle definido. Dentro de él organizaremos e identificaremos qué tipos de operadores hay, y qué significan dichos operadores. Suma, resta, etc.
	For $I = 0 To UBound($aOperadores, 1) - 1
		If Not $I = UBound($aOperadores, 1) - 1 Then $sDeCadaUno &= $aOperadores[$I][0] & " "
		If $aOperadores[$I][0] = 1 Then
			$bPlural = False
		Else
			$bPlural = True
		EndIf
		If Not $I = UBound($aOperadores, 1) - 1 Then
			$sDeCadaUno &= _Operator_GetName($aOperadores[$I][1], $bPlural) & ", "
		Else
			$sDeCadaUno &= " y " & $aOperadores[$I][0] & " " & _Operator_GetName($aOperadores[$I][1], $bPlural) & "."
		EndIf
	Next
	$hFile = FileOpen(@ScriptDir & "\tarea de " & UBound($aTarea) & " operaciones.txt", 1)
	FileWrite($hFile, "Tarea matemática" & @CRLF & "La tarea tiene: " & $sDeCadaUno & @CRLF & "Resuelva las siguientes operaciones:" & @CRLF)
	FileWrite($hFile, _ArrayToString($aTarea, @CRLF))
	FileClose($hFile)
	MsgBox(0, "éxito", "He creado una tarea. Puedes revisarla y realizarla.")
EndFunc   ;==>Main