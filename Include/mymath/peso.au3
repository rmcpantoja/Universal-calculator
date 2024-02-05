;Esta es una UDF para calcular distintas cosas o utilidades si quieres saber más acerca de tu peso: ¡Nueva versión optimizada!
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _Libras_A_Quilos
; Description ...: como su nombre lo indica, convertir un número específico de libras a quilos.
; Syntax ........: _Libras_A_Quilos($NLibras)
; Parameters ....: $NLibras             - Número de libras a convertir.
; Return values .: El número de quilos convertidos
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Libras_A_Quilos($nLibras)
	If Not StringIsAlNum($nLibras) Or Not IsNumber($nLibras) Or Not IsInt($nLibras) Then Return SetError(1, 0, "")
	Return $nLibras / 2.2
EndFunc   ;==>_Libras_A_Quilos
; #FUNCTION# ====================================================================================================================
; Name ..........: _Quilos_A_Libras
; Description ...: Como su nombre lo indica, convierte un número específico de quilos a libras.
; Syntax ........: _Quilos_A_Libras($nQuilos)
; Parameters ....: $nQuilos             - Un número específico de quilos a convertir.
; Return values .: Resultado convertido en libras.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Quilos_A_Libras($nQuilos)
	If Not StringIsAlNum($nQuilos) Or Not IsNumber($nQuilos) Or Not IsInt($nQuilos) Then Return SetError(1, 0, "")
	Return $nQuilos * 2.2
EndFunc   ;==>_Quilos_A_Libras
; #FUNCTION# ====================================================================================================================
; Name ..........: _estatura_Centimetros_A_KG
; Description ...: convierte centímetros a kilogramos.
; Syntax ........: _estatura_Centimetros_A_KG($nCentimetros)
; Parameters ....: $nCentimetros        - Número de centímetros a convertir.
; Return values .: El resultado convertido a kilogramos.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _estatura_Centimetros_A_KG($nCentimetros)
	If Not StringIsAlNum($nCentimetros) Or Not IsNumber($nCentimetros) Or Not IsInt($nCentimetros) Then Return SetError(1, 0, "")
	Return $nCentimetros - 100
EndFunc   ;==>_estatura_Centimetros_A_KG
; #FUNCTION# ====================================================================================================================
; Name ..........: _estatura_KG_a_Centimetros
; Description ...: Convierte kilogramos a centímetros.
; Syntax ........: _estatura_KG_a_Centimetros($nKg)
; Parameters ....: $nKg                 - Número de kilogramos a convertir.
; Return values .: El resultado convertido a libras.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _estatura_KG_a_Centimetros($nKg)
	If Not StringIsAlNum($nKg) Or Not IsNumber($nKg) Or Not IsInt($nKg) Then Return SetError(1, 0, "")
	Return $nKg + 100
EndFunc   ;==>_estatura_KG_a_Centimetros
; #FUNCTION# ====================================================================================================================
; Name ..........: _IMC
; Description ...: Masa Corporal
; Syntax ........: _IMC($nKilos, $nEstatura)
; Parameters ....: $nKilos                  - número de quilos.
;                  $nEstatura      - La estatura (en metros).
; Return values .: El resultado de Masa Corporal
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IMC($nKilos, $nEstatura)
	If StringIsAlNum($nKilos) Or StringIsFloat($nKilos) And StringIsAlNum($nEstatura) Or StringIsFloat($nEstatura) Then
		$nFormula = $nKilos / $nEstatura
		Return $nFormula / $nEstatura
	Else
		Return 0
	EndIf
EndFunc   ;==>_IMC
; #FUNCTION# ====================================================================================================================
; Name ..........: _IMC_get_status
; Description ...: Obtiene las estadísticas de tu IMC.
; Syntax ........: _IMC_get_status($nIMC)
; Parameters ....: $nIMC                - El IMC obtenido con _IMC.
; Return values .: El estado del IMC.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IMC_get_status($nIMC)
	Switch $nIMC
		Case 8 to 18.49
			Return "low"
		Case 18.5 To 24.99
			Return "normal"
		Case 25 To 29.99
			Return "high"
		Case 30 To 34.99
			Return "higher"
		Case 35 To 39.99
			Return "higuest"
		Case 40 to 60
			Return "ultra"
		case else
			return SetError(1, 0, "")
	EndSwitch
EndFunc   ;==>_IMC_get_status
; #FUNCTION# ====================================================================================================================
; Name ..........: _IMC_en_Libras
; Description ...: aplica Masa Corporal en libras.
; Syntax ........: _IMC_en_Libras($nl, $estaturametros)
; Parameters ....: $nl                  - Número de libras de la persona.
;                  $estaturametros      - Metros de estatura.
; Return values .: El resultado de Masa Corporal
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IMC_en_Libras($nl, $estaturametros)
	If StringIsAlNum($nl) Or StringIsFloat($nl) And StringIsAlNum($estaturametros) Or StringIsFloat($estaturametros) Then
		$formula = _Libras_A_Quilos($nl) / $estaturametros
		Return $formula / $estaturametros
	Else
		Return 0
	EndIf
EndFunc   ;==>_IMC_en_Libras
