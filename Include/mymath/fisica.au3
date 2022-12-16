;fisica
; #FUNCTION# ====================================================================================================================
; Name ..........: _D_o_X
; Description ...: obtiene el valor de D o X.
; Syntax ........: _D_o_X($nVelocidad, $nTiempo)
; Parameters ....: $nVelocidad          - Velocidad (m/s).
;                  $nTiempo             - Tiempo establecido para obtener la distancia.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D_o_X($nVelocidad, $nTiempo)
if not isNumber($nVelocidad) or not isNumber($nTiempo) then Return SetError(1, 0, "")
return $nVelocidad*$nTiempo
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _Velocidad
; Description ...:
; Syntax ........: _Velocidad($nDistancia, $nTiempo)
; Parameters ....: $nDistancia          - a general number value.
;                  $nTiempo             - a general number value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _Velocidad($nDistancia, $nTiempo)
if not isNumber($nDistancia) or not isNumber($nTiempo) then Return SetError(1, 0, "")
return $nDistancia*$nTiempo
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _aceleracion
; Description ...:
; Syntax ........: _aceleracion($nVelocidad, $nTiempo)
; Parameters ....: $nVelocidad          - a general number value.
;                  $nTiempo             - a general number value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _aceleracion($nVelocidad, $nTiempo)
if not isNumber($nVelocidad) or not isNumber($nTiempo) then Return SetError(1, 0, "")
return $nVelocidad/$nTiempo
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _tiempo
; Description ...:
; Syntax ........: _tiempo($nVelocidad, $nDistancia)
; Parameters ....: $nVelocidad          - a general number value.
;                  $nDistancia          - a general number value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _tiempo($nVelocidad, $nDistancia)
if not isNumber($nVelocidad) or not isNumber($nDistancia) then Return SetError(1, 0, "")
return $nVelocidad/$nDistancia
EndFunc
