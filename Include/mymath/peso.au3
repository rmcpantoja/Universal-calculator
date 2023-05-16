;Esta es una UDF para calcular distintas cosas o utilidades si quieres saber más acerca de tu peso: ¡Nueva versión optimizada!
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _Libras_A_Quilos
; Description ...:
; Syntax ........: _Libras_A_Quilos($NLibras)
; Parameters ....: $NLibras             - an unknown value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Libras_A_Quilos($NLibras)
	If not StringIsAlNum($nLibras) Or not IsNumber($nLibras) or not IsInt($nLibras) Then return SetError(1, 0, "")
	Return $nLibras / 2.2
EndFunc   ;==>_Libras_A_Quilos
; #FUNCTION# ====================================================================================================================
; Name ..........: _Quilos_A_Libras
; Description ...:
; Syntax ........: _Quilos_A_Libras($nQuilos)
; Parameters ....: $nQuilos             - a general number value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Quilos_A_Libras($nQuilos)
	If not StringIsAlNum($nQuilos) Or not IsNumber($nQuilos) or not IsInt($nQuilos) Then Return SetError(1, 0, "")
	Return $nQuilos * 2.2
EndFunc   ;==>_Quilos_A_Libras
; #FUNCTION# ====================================================================================================================
; Name ..........: _estatura_Centimetros_A_KG
; Description ...:
; Syntax ........: _estatura_Centimetros_A_KG($nCentimetros)
; Parameters ....: $nCentimetros        - a general number value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _estatura_Centimetros_A_KG($nCentimetros)
	If not StringIsAlNum($nCentimetros) Or not IsNumber($nCentimetros) or not IsInt($nCentimetros) Then Return SetError(1, 0, "")
	Return $nCentimetros - 100
EndFunc   ;==>_estatura_Centimetros_A_KG
; #FUNCTION# ====================================================================================================================
; Name ..........: _estatura_KG_a_Centimetros
; Description ...:
; Syntax ........: _estatura_KG_a_Centimetros($nKg)
; Parameters ....: $nKg                 - a general number value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _estatura_KG_a_Centimetros($nKg)
	If not StringIsAlNum($nKg) Or not IsNumber($nKg) or not IsInt($nKg) Then return setError(1, 0, "")
	Return $nKg + 100
EndFunc   ;==>_estatura_KG_a_Centimetros
; #FUNCTION# ====================================================================================================================
; Name ..........: _IMC
; Description ...:
; Syntax ........: _IMC($nk, $estaturametros)
; Parameters ....: $nk                  - a general number value.
;                  $estaturametros      - an unknown value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IMC($nk, $estaturametros)
	If StringIsAlNum($nk) Or StringIsFloat($nk) And StringIsAlNum($estaturametros) Or StringIsFloat($estaturametros) Then
		$formula = $nk / $estaturametros
		Return $formula / $estaturametros
	Else
		Return 0
	EndIf
EndFunc   ;==>_IMC
; #FUNCTION# ====================================================================================================================
; Name ..........: _IMC_en_Libras
; Description ...:
; Syntax ........: _IMC_en_Libras($nl, $estaturametros)
; Parameters ....: $nl                  - a general number value.
;                  $estaturametros      - an unknown value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IMC_en_Libras($nl, $estaturametros)
	If StringIsAlNum($nl) Or StringIsFloat($nl) And StringIsAlNum($estaturametros) Or StringIsFloat($estaturametros) Then
		$formula = LibrasAQuilos($nl) / $estaturametros
		Return $formula / $estaturametros
	Else
		Return 0
	EndIf
EndFunc   ;==>_IMC_a_Libras
