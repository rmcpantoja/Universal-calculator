;Esta es una UDF para calcular distintas cosas o utilidades si quieres saber más acerca de tu peso: ¡Nueva versión optimizada!
#include-once
func _Libras_A_Quilos($NumeroLibras)
If StringIsAlNum($NumeroLibras) or StringIsFloat($NumeroLibras) Then
return $NumeroLibras/2.2
else
return 0
EndIf
EndFunc
func _Quilos_A_Libras($NumeroQuilos)
If StringIsAlNum($NumeroQuilos) or StringIsFloat($NumeroQuilos) Then
return $NumeroQuilos*2.2
else
return 0
EndIf
EndFunc
func _estatura_Centimetros_A_KG($cent)
If StringIsAlNum($cent) OR StringIsFloat($cent) Then
return $cent-100
else
return 0
EndIf
EndFunc
func _estatura_KG_a_Centimetros($KG)
If StringIsAlNum($kg) OR StringIsFloat($kg) Then
return $kg+100
else
return 0
EndIf
EndFunc
func _IMC($numerok, $estaturametros)
If StringIsAlNum($numerok) or StringIsFloat($numerok) and StringIsAlNum ($estaturametros) or StringIsFloat($estaturametros) Then
$formula = $numerok / $estaturametros
return $formula/$estaturametros
else
return 0
EndIF
EndFunc
func _IMC_a_Libras($numerol, $estaturametros)
If StringIsAlNum($numerol) or StringIsFloat($numerol) and StringIsAlNum ($estaturametros) or StringIsFloat($estaturametros) Then
$formula = LibrasAQuilos($numerol) / $estaturametros
return $formula/$estaturametros
else
return 0
EndIF
EndFunc