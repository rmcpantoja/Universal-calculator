;UDF para potencia o elevación.
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _Elevado
; Description ...: Realiza una potencia.
; Syntax ........: _Elevado($nX, $nNumParaElevar[, $bRazon = false])
; Parameters ....: $nX                  - Número base a ser elevado.
;                  $nNumParaElevar      - El número exponente, por ej: 2 = al cuadrado, 3 = al cubo.
;                  $bRazon              - [opcional] Un balor booleano por si queremos obtener la razón de esa potencia. Por defecto es falso.
; Return values .: El número elevado. Si obtienes la razón, se te retorna una matriz 1d de dos elementos, cual primer elemento es el resultado y el segundo la razón.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _Elevado($nX, $nNumParaElevar, $bRazon = False)
	Local $aResult[]
	If IsNumber($nX) and isNumber($nNumParaElevar) then
		$nPrimTerm = $nX
		$sReason = $nPrimTerm
		For $I = 1 To $nNumParaElevar - 1
			$nX = $nX * $nPrimTerm
			If $bRazon Then $sReason &= " * " & $nPrimTerm & " = " & $nX
		Next
		If Not $bRazon Then
			Return $nX
		Else
			$aResult[0] = $nX
			$aResult[1] = $sReason
			Return $aResult
		EndIf
	Else
		return SetError(1, 0, "")
	EndIf
EndFunc   ;==>_Elevado
