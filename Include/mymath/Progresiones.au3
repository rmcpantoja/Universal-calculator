;Este es una UDF para progresiones aritméticas y geométricas.
;Autor del UDF: Mateo Cedillo.
#include "elevar.au3"
#include "raiz.au3"
#include-once
;Las siguientes funciones son para progresiones aritméticas:
; #FUNCTION# ====================================================================================================================
; Name ..........: _a1
; Description ...: Obtiene el primer término de una progresión aritmética
; Syntax ........: _a1($nAn, $nN, $nDif)
; Parameters ....: $nAn                 - El término enésimo.
;                  $nN                  - El número de término.
;                  $nDif                - El número de diferencia.
; Return values .: El primer término acorde a los parámetros establecidos.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _a1($nAn, $nN, $nDif)
	If not IsNumber($nAn) and not IsNumber($nN) and not IsNumber($nDif) then return SetError(1, 0, "")
	Return $nAn - ($nN - 1) - $nDif * $nDif
EndFunc   ;==>_a1
; #FUNCTION# ====================================================================================================================
; Name ..........: _Diference
; Description ...: Obtiene la diferencia de una progresión aritmética.
; Syntax ........: _Diference($nAn, $nA1, $nN)
; Parameters ....: $nAn                 - El número que contiene el término enésimo.
;                  $nA1                 - El número que contenga el primer término.
;                  $nN                  - El número de término.
; Return values .: El resultado final de la diferencia
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _Diference($nAn, $nA1, $nN)
	If not IsNumber($nAn) and not IsNumber($nA1) and not IsNumber($nN) then return SetError(1, 0, "")
	Return ($nAn - $nA1) / ($nN - 1)
EndFunc   ;==>_Diference
; #FUNCTION# ====================================================================================================================
; Name ..........: _NumTerm
; Description ...: Obtiene el número de término de una progresión aritmética.
; Syntax ........: _NumTerm($nAn, $nA1, $nDif)
; Parameters ....: $nAn                 - El término enésimo.
;                  $nA1                 - EL primer término.
;                  $nDif                - EL número de diferencia.
; Return values .: El número de término
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _NumTerm($nAn, $nA1, $nDif)
	If not IsNumber($nAn) and not IsNumber($nA1) and not IsNumber($nDif) then return SetError(1, 0, "")
	Return (($nAn - $nA1) / $nDif) + 1
EndFunc   ;==>_NumTerm
; #FUNCTION# ====================================================================================================================
; Name ..........: _An
; Description ...: Obtiene el término enésimo de una progresión aritmética.
; Syntax ........: _An($nA1, $nN, $nDif)
; Parameters ....: $nA1                 - El número que contiene el primer término.
;                  $nN                  - El número de término.
;                  $nDif                - El número que contenga la diferencia.
; Return values .: El término enésimo
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _An($nA1, $nN, $nDif)
	If not IsNumber($nA1) and not IsNumber($nN) and not IsNumber($nDif) then return SetError(1, 0, "")
	Return $nA1 + ($nN - 1) * $nDif
EndFunc   ;==>_An
; #FUNCTION# ====================================================================================================================
; Name ..........: _Sn1
; Description ...: Primer método que obtiene la suma de los términos de una progresión aritmética.
; Syntax ........: _Sn1($nAn, $nA1, $nN)
; Parameters ....: $nAn                 - El término enésimo.
;                  $nA1                 - El ´rimer término.
;                  $nN                  - El número de término.
; Return values .: El resultado final de la suma de los términos.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _Sn1($nAn, $nA1, $nN)
	If not IsNumber($nAn) and not IsNumber($nA1) and not IsNumber($nN) then return SetError(1, 0, "")
	Return (($nAn + $nA1) / 2) * $nN
EndFunc   ;==>_Sn1
; #FUNCTION# ====================================================================================================================
; Name ..........: _Sn2
; Description ...: Segundo método para sumar términos de una progresión aritmética.
; Syntax ........: _Sn2($nN, $nA1, $nDif)
; Parameters ....: $nN                  - El número de término.
;                  $nA1                 - El primer término.
;                  $nDif                - El número que contenga la diferencia.
; Return values .: La suma de los términos
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......: Esta función por ahora no está funcionando correctamente.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Sn2($nN, $nA1, $nDif)
	If not IsNumber($nN) and not IsNumber($nA1) and not IsNumber($nDif) then return SetError(1, 0, "")
	Return $nN / ($nA1 * 2 + ($nN - 1) * $nDif)
EndFunc   ;==>_Sn2
; Las siguientes funciones son para progresiones geométricas:
; #FUNCTION# ====================================================================================================================
; Name ..........: _An2
; Description ...: Obtiene el término enéismo de una progresión geométrica.
; Syntax ........: _An2($nA1, $nR, $nN)
; Parameters ....: $nA1                 - El primer término.
;                  $nR                  - El número que contiene la razón.
;                  $nN                  - El número de término.
; Return values .: El número que contiene el término enésimo.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _An2($nA1, $nR, $nN)
	If not IsNumber($nA1) and not IsNumber($nR) and not IsNumber($nN) then return SetError(1, 0, "")
	Return $nA1 * _Elevado($nR, $nN - 1)
EndFunc   ;==>_An2
; #FUNCTION# ====================================================================================================================
; Name ..........: _a12
; Description ...: Obtiene el primer término de una progresión geométrica.
; Syntax ........: _a12($nAN, $nR, $nN)
; Parameters ....: $nAN                 - El número que contiene el término enésimo.
;                  $nR                  - El número que contiene la razón.
;                  $nN                  - el número de término.
; Return values .: El primer término
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _a12($nAN, $nR, $nN)
	If not IsNumber($nAn) and not IsNumber($nR) and not IsNumber($nN) then return SetError(1, 0, "")
	Return $nAN / _elevado($nR, $nN - 1)
EndFunc   ;==>_a12
; #FUNCTION# ====================================================================================================================
; Name ..........: _r
; Description ...: Obtiene la razón de una progresión geométrica.
; Syntax ........: _r($nN, $nAn, $nA1)
; Parameters ....: $nN                  - el número de término.
;                  $nAn                 - el número que contiene el término enésimo.
;                  $nA1                 - el ´rimer término.
; Return values .: El número que contiene la razón.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _r($nN, $nAN, $nA1)
	If not IsNumber($nN) and not IsNumber($nAn) and not IsNumber($nA1) then return SetError(1, 0, "")
	Return _raiz2($nN - 1, $nAN / $nA1)
EndFunc   ;==>_r
; #FUNCTION# ====================================================================================================================
; Name ..........: _NumTerm2
; Description ...: Obtiene el número de término de una progresión geométrica.
; Syntax ........: _NumTerm2($nAn, $nA1, $nR)
; Parameters ....: $nAn                 - El  número que contiene el término enésimo.
;                  $nA1                 - el primer término.
;                  $nR                  - el número que contenga la razón.
; Return values .: El número de término
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _NumTerm2($nAN, $nA1, $nR)
	If not IsNumber($nAn) and not IsNumber($nA1) and not IsNumber($nR) then return SetError(1, 0, "")
	Return ((Log($nAN) - Log($nA1)) / Log($nR)) + 1
EndFunc   ;==>_NumTerm2
; #FUNCTION# ====================================================================================================================
; Name ..........: _Sn3
; Description ...: Primer método que obtiene la suma de los términos de una progresión geométrica.
; Syntax ........: _Sn3($nAn, $nR)
; Parameters ....: $nAn                 - el número que contiene el término enésimo.
;                  $nR                  - el número que contiene la razón.
; Return values .: El resultado final de la suma de términos.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _Sn3($nAN, $nR)
	If not IsNumber($nAn) and not IsNumber($nR) then return SetError(1, 0, "")
	Return ($nAN * $nR - 1 / ($nR - 1))
EndFunc   ;==>_Sn3
; #FUNCTION# ====================================================================================================================
; Name ..........: _Sn4
; Description ...: Segundo método que obtiene la suma de los términos de una progresión geométrica.
; Syntax ........: _Sn4($nA1, $nR, $nN)
; Parameters ....: $nA1                 - el primer término.
;                  $nR                  - el número que contiene la razón.
;                  $nN                  - el número de término.
; Return values .: El resultado final con la suma de los términos
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _Sn4($nA1, $nR, $nN)
	If not IsNumber($nA1) and not IsNumber($nR) and not IsNumber($nN) then return SetError(1, 0, "")
	Return $nA1 * (_elevado($nR, $nN - 1)) / ($nR - 1)
EndFunc   ;==>_Sn4