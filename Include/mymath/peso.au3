;Esta es una UDF para calcular distintas cosas o utilidades si quieres saber más acerca de tu peso: ¡Nueva versión optimizada!
#include-once
Func _Libras_A_Quilos($NLibras)
	If not StringIsAlNum($nLibras) Or not IsNumber($nLibras) or not IsInt($nLibras) Then return SetError(1, 0, "")
	Return $nLibras / 2.2
EndFunc   ;==>_Libras_A_Quilos
Func _Quilos_A_Libras($nQuilos)
	If not StringIsAlNum($nQuilos) Or not IsNumber($nQuilos) or not IsInt($nQuilos) Then Return SetError(1, 0, "")
	Return $nQuilos * 2.2
EndFunc   ;==>_Quilos_A_Libras
Func _estatura_Centimetros_A_KG($nCentimetros)
	If not StringIsAlNum($nCentimetros) Or not IsNumber($nCentimetros) or not IsInt($nCentimetros) Then Return SetError(1, 0, "")
	Return $nCentimetros - 100
EndFunc   ;==>_estatura_Centimetros_A_KG
Func _estatura_KG_a_Centimetros($nKg)
	If not StringIsAlNum($nKg) Or not IsNumber($nKg) or not IsInt($nKg) Then return setError(1, 0, "")
	Return $nKg + 100
EndFunc   ;==>_estatura_KG_a_Centimetros
Func _IMC($nk, $estaturametros)
	If StringIsAlNum($nk) Or StringIsFloat($nk) And StringIsAlNum($estaturametros) Or StringIsFloat($estaturametros) Then
		$formula = $nk / $estaturametros
		Return $formula / $estaturametros
	Else
		Return 0
	EndIf
EndFunc   ;==>_IMC
Func _IMC_a_Libras($nl, $estaturametros)
	If StringIsAlNum($nl) Or StringIsFloat($nl) And StringIsAlNum($estaturametros) Or StringIsFloat($estaturametros) Then
		$formula = LibrasAQuilos($nl) / $estaturametros
		Return $formula / $estaturametros
	Else
		Return 0
	EndIf
EndFunc   ;==>_IMC_a_Libras
