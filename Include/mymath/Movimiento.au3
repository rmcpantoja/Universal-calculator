#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _AlturaMaxima
; Description ...: Obtener altura máxima.
; Syntax ........: _AlturaMaxima($nVelocidadInicial, $nANgulo, $nGravedad)
; Parameters ....: $nVelocidadInicial   - a general number value.
;                  $nANgulo             - a general number value.
;                  $nGravedad           - a general number value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _AlturaMaxima($nVelocidadInicial, $nANgulo, $nGravedad)
	$nProcess = ($nVelocidadInicial * $nVelocidadInicial)
	$nSin = Sin($nProcess)
	$nProcess2 = $nSin * $nSin * $nANgulo / 2 * $nGravedad
	Return $nProcess2
EndFunc   ;==>_AlturaMaxima
; #FUNCTION# ====================================================================================================================
; Name ..........: _Angulo
; Description ...:
; Syntax ........: _Angulo($nGravedad, $nTiempo, $nVelocidadInicial)
; Parameters ....: $nGravedad           - a general number value.
;                  $nTiempo             - a general number value.
;                  $nVelocidadInicial   - a general number value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Angulo($nGravedad, $nTiempo, $nVelocidadInicial)
	$nResult = $nGravedad * $nTiempo / $nVelocidadInicial
	Return Round($nResult)
EndFunc   ;==>_Angulo
