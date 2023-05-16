; Creador de operaciones muy cool.
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: generarOperacion
; Description ...: Crea una suma, resta, multiplicación, división o potencia.
; Syntax ........: generarOperacion($sOperador[, $iModo = 2[, $iMultDificult = 1]])
; Parameters ....: $sOperador           - Uno de los cinco operadores disponibles. +, -, *, /, y el signo de potencia (^).
;                  $iModo               - [opcional] La medida de la operación. 1 = crear operaciones que contienen una unidad, 2 = decena, 3 = centena, etc. Por defecto es 2 (crea operaciones con decenas).
;                  $iMultDificult       - [opcional] Un valor para indicar la dificultad al momento de crear una multiplicación (si el operador tiene "*"). Por defecto es 1 (principiante).
; Return values .: La operación generada
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func generarOperacion($sOperador, $iModo = 2, $iMultDificult = 1)
	If Not IsString($sOperador) Then Return SetError(1, 0, "")
	If Not $sOperador = "+" Or Not $sOperador = "-" Or Not $sOperador = "*" Or Not $sOperador = "/" Or Not $sOperador = "^" Then Return SetError(2, 0, "")
	If Not IsInt($iModo) Or Not IsInt($iMultDificult) Then Return SetError(3, 0, "")
	If $iMultDificult > 3 Then Return SetError(4, 0, "")
	Local $nPrimerTermino, $nSegundoTermino, $nRango, $iDificultad
	; aremos una especie de rangos para los modos.
	$nRango = _GenerarRango($iModo)
	; ahora convertimos ese rango en una matriz separando el mínimo y el máximo para ponerlos en una columna.
	$aRango = StringSplit($nRango, "-")
	Select
		Case $sOperador = "-" Or $sOperador = "+"
			; generamos el primer término de acuerdo al rango:
			$nPrimerTermino = Int(Random($aRango[1], $aRango[2]))
			; segundo término:
			$nSegundoTermino = Int(Random($aRango[1], $nPrimerTermino))
		Case $sOperador = "*"
			$nPrimerTermino = Int(Random($aRango[1], $aRango[2]))
			; aquí tomamos en cuenta el $iMultDificult:
			$iDificultad = Int(StringLen($nPrimerTermino) * $iMultDificult / 3)
			If $iDificultad = 0 Or StringLen($iDificultad) > 1 Then
				Local $aNuevoRango = ["", 1, 9]
			Else
				$aNuevoRango = StringSplit(_GenerarRango($iDificultad), "-")
			EndIf
			$nSegundoTermino = Int(Random($aNuevoRango[1], $aNuevoRango[2]))
			If $nSegundoTermino > $nPrimerTermino Then $nSegundoTermino = Int($nSegundoTermino - $nPrimerTermino)
		Case $sOperador = "/"
			$nPrimerTermino = Int(Random($aRango[1], $aRango[2]))
			$nSegundoTermino = Int(Random($aRango[1], $nPrimerTermino)/4)
		Case $sOperador = "^"
	EndSelect
	; finalmente, hacemos que la función retorne la operación generada. Así, ¡Cuando llames a la función te dará esa resta y deberías aplicarla para ver su igual! No se vale hacer trampas, como usar la función execute. Bueno, se puede usar, pero hmm no en ese plan de trampa.
	Return $nPrimerTermino & $sOperador & $nSegundoTermino
EndFunc   ;==>generarOperacion
; #FUNCTION# ====================================================================================================================
; Name ..........: _GenerarRango
; Description ...: Función que genera un rango de acuerdo al número de unidades.
; Syntax ........: _GenerarRango($iMode)
; Parameters ....: $iMode               - El número de unidades. 1 = unidad, 2 = decena, 3 = centena...
; Return values .: Un rango de 1x a 9x (insertando los ceros que corresponden)
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _GenerarRango($iMode)
	If $iMode < 1 Then Return SetError(1, 0, "")
	Local $iStart = 1, $iEnd = 9
	Local $sRango = ""
	$sRango = $iStart
	If $iMode > 1 Then
		For $I = 0 To $iMode - 2
			$sRango &= "0"
		Next
	EndIf
	$sRango &= "-"
	For $I = 0 To $iMode - 1
		$sRango &= $iEnd
	Next
	Return $sRango
EndFunc   ;==>_GenerarRango
