; creador de tarea usando la UDF para generación de operaciones:
; Como el generador de operaciones es muy cool, el creador de tareas lo es más. :)
; incluyendo dependencias:
#include "array.au3"
#include "generador_operaciones.au3"
#include-once
; declarando:
Global $sOperators
; aquí vamos a establecer todos los operadores matemáticos que se puede soportar para hacer tareas:
$sOperators = "+-*/^"
; #FUNCTION# ====================================================================================================================
; Name ..........: _CrearTarea
; Description ...: crea una tarea matemática basándose en un nivel de aprendizaje en específico.
; Syntax ........: _CrearTarea($nNivel)
; Parameters ....: $nNivel              - El número de nivel. 1 = principiante, 2 = medio, 3 = avanzado/difícil.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......: Cada nivel proporciona un mayor esfuerzo por realizar, ya que mientras más alto el nivel puede generar más operaciones como divisiones y potencia en el caso de un nivel difícil.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _CrearTarea($nNivel)
	; 1 fácil, 2 intermedio, 3 difícil
	Local $aOperaciones[0]
	Local $iCuantas
	Local $sOperador
	If Not IsNumber($nNivel) Then Return SetError(1, 0, "")
	Switch $nNivel
		Case 1
			$iCuantas = Random(3, 10, 1)
		Case 2
			$iCuantas = Random(10, 25, 1)
		Case 3
			$iCuantas = Random(25, 50, 1)
	EndSwitch
	For $I = 0 To $iCuantas - 1
		$sOperador = _GenerateOperator(Random(1, 3, 1))
		$sOperacion = generarOperacion($sOperador, Int(_dificultades($nNivel)), Int($nNivel))
		If @error Then
			Return SetError(2, 0, "")
			ExitLoop
		EndIf
		ReDim $aOperaciones[UBound($aOperaciones) + 1]
		$aOperaciones[$I] = $sOperacion
	Next
	Return $aOperaciones
EndFunc   ;==>_CrearTarea
; #FUNCTION# ====================================================================================================================
; Name ..........: _dificultades
; Description ...: Crea un número de unidades basándose en una dificultad.
; Syntax ........: _dificultades($iDif)
; Parameters ....: $iDif                - nivel de dificultad. 1  fácil, 2 intermedio, 3 difícil.
; Return values .: El número de unidades
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _dificultades($iDif)
	Local $iResult
	If Not IsInt($iDif) Then Return SetError(1, 0, "")
	Switch $iDif
		Case 1
			$iResult = Random(1, 2)
		Case 2
			$iResult = Random(2, 4)
		Case 3
			$iResult = Random(4, 6)
	EndSwitch
	Return $iResult
EndFunc   ;==>_dificultades
; #FUNCTION# ====================================================================================================================
; Name ..........: _GenerateOperator
; Description ...: Devuelbe un operador entre una matriz donde se almacenan todos los operadores.
; Syntax ........: _GenerateOperator($iOperator)
; Parameters ....: $iOperator           - el número de operador. 1 suma, 2 resta...
; Return values .: Una cadena que contiene el operador
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _GenerateOperator($iOperator)
	If $iOperator > 5 Then Return SetError(1, 0, "")
	Local $aOperator = ["+", "-", "*", "/", "^"]
	Return $aOperator[$iOperator - 1]
EndFunc   ;==>_GenerateOperator
; #FUNCTION# ====================================================================================================================
; Name ..........: _Operator_GetName
; Description ...: Obtiene el nombre del signo de operador.
; Syntax ........: _Operator_GetName($sOperator[, $bPlural = False])
; Parameters ....: $sOperator           - una cadena que contiene el signo operador (+-*/^).
;                  $bPlural             - [opcional] Un valor booleano para retornar el resultado de forma plural. Por defecto es False.
; Return values .: El nombre del signo operador
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _Operator_GetName($sOperator, $bPlural = False)
	Local $aNames[] = ["suma", "resta", "multiplicación", "división", "potencia"]
	Local $aOperator = ["+", "-", "*", "/", "^"]
	Local $sCurrent
	If Not IsString($sOperator) Then Return SetError(1, 0, "")
	For $I = 0 To UBound($aNames) - 1
		If $aOperator[$I] = $sOperator Then
			If $bPlural Then
				If StringInStr($aNames[$I], "ón") Then
					Return StringReplace($aNames[$I], "ón", "ones")
				Else
					Return $aNames[$I] & "s"
				EndIf
			Else
				Return $aNames[$I]
			EndIf
			ExitLoop
		EndIf
	Next
EndFunc   ;==>_Operator_GetName
; #FUNCTION# ====================================================================================================================
; Name ..........: _operation_getOperator
; Description ...: Busca cuál es el operador de una operación y lo retorna. Por ej: si la operación es 20*20, entonces retornará * (el operador).
; Syntax ........: _operation_getOperator($sOperation)
; Parameters ....: $sOperation          - Una cadena que contiene la operación.
; Return values .: El operador que tiene esta operación
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _operation_getOperator($sOperation)
	Local $iLen
	Local $sCurrent
	If Not IsString($sOperation) Then Return SetError(1, 0, "")
	$iLen = StringLen($sOperation)
	If $iLen > 24 Then Return SetError(2, 0, "")
	For $I = 1 To $iLen
		$sCurrent = StringMid($sOperation, $I, 1)
		If StringInStr($sOperators, $sCurrent) Then
			Return $sCurrent
			ExitLoop
		EndIf
	Next
	Return SetError(3, 0, "")
EndFunc   ;==>_operation_getOperator
; #FUNCTION# ====================================================================================================================
; Name ..........: _count_homework_Operators
; Description ...: Cuenta el número de los operadores que contiene la tarea actual (debe ser un array creado con _CrearTarea).
; Syntax ........: _count_homework_Operators($aHomework)
; Parameters ....: $aHomework           - Una matriz que tenga la información de la tarea creada con _CrearTarea.
; Return values .: El número de operadores que contiene la tarea
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _count_homework_Operators($aHomework)
	Local $iResult
	Local $sCurrent, $sHomework, $sCurrentOperators
	If Not IsArray($aHomework) Then Return SetError(1, 0, "")
	Local $aResults[0][2]
	$sHomework = _ArrayToString($aHomework)
	$sCurrentOperators = _regexOcurrence($sHomework, "|1234567890")
	For $I = 0 To StringLen($sOperators) - 1
		$sCurrent = StringMid($sOperators, $I + 1, 1)
		$iResult = Int(_get_number_of_ocurrences($sCurrentOperators, $sCurrent))
		If Not $iResult = 0 Then
			ReDim $aResults[UBound($aResults, 1) + 1][UBound($aResults, 2)]
			$aResults[$I][0] = $iResult
			$aResults[$I][1] = $sCurrent
		EndIf
	Next
	Return $aResults
EndFunc   ;==>_count_homework_Operators
; #FUNCTION# ====================================================================================================================
; Name ..........: _get_number_of_ocurrences
; Description ...:
; Syntax ........: _get_number_of_ocurrences($sText, $sChar)
; Parameters ....: $sText               - a string value.
;                  $sChar               - a string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _get_number_of_ocurrences($sText, $sChar)
	Return StringLen($sText) - StringLen(StringReplace($sText, $sChar, ''))
EndFunc   ;==>_get_number_of_ocurrences
; #FUNCTION# ====================================================================================================================
; Name ..........: _regexOcurrence
; Description ...:
; Syntax ........: _regexOcurrence($sText, $sRegEx)
; Parameters ....: $sText               - a string value.
;                  $sRegEx              - a string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _regexOcurrence($sText, $sRegEx)
	Local $sResult = StringRegExpReplace($sText, "[" & $sRegEx & "]", '')
	Return $sResult
EndFunc   ;==>_regexOcurrence
