;Esta es una UDF para calcular distintas cosas o utilidades si quieres saber más acerca de tu peso: ¡Nueva versión optimizada!
#include-once
func LibrasAQuilos($NumeroLibras)
If StringIsAlNum($NumeroLibras) or StringIsFloat($NumeroLibras) Then
return $NumeroLibras/2.2
else
return 0
EndIf
EndFunc
func QuilosALibras($NumeroQuilos)
If StringIsAlNum($NumeroQuilos) or StringIsFloat($NumeroQuilos) Then
return $NumeroQuilos*2.2
else
return 0
EndIf
EndFunc
func estatura_Centimetros2KG($cent)
If StringIsAlNum($cent) OR StringIsFloat($cent) Then
return $cent-100
else
return 0
EndIf
EndFunc
func estatura_KG2Centimetros($KG)
If StringIsAlNum($kg) OR StringIsFloat($kg) Then
return $kg+100
else
return 0
EndIf
EndFunc
func IMC($numerok, $estaturametros)
If StringIsAlNum($numerok) or StringIsFloat($numerok) and StringIsAlNum ($estaturametros) or StringIsFloat($estaturametros) Then
$formula = $numerok / $estaturametros
return $formula/$estaturametros
else
return 0
EndIF
EndFunc
func IMC2Libras($numerol, $estaturametros)
If StringIsAlNum($numerol) or StringIsFloat($numerol) and StringIsAlNum ($estaturametros) or StringIsFloat($estaturametros) Then
$formula = LibrasAQuilos($numerol) / $estaturametros
return $formula/$estaturametros
else
return 0
EndIF
EndFunc