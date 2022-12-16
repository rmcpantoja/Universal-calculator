;Qué bruto... Hice este UDF sin saber que había una función nativa de autoit que hacía eso (sqrt) y después de hacer el UDF y buscar info en internet me doy cuenta. ¡Qué vestia!
;Al menos, este UDF lo que trata es hacer no solo raíces cuadradas sino cúbicas, cuartas, quintas, etc etc.
;Además, puedes obtener la razón de esa raíz que hayas resuelto, ej: ¿Por qué la raíz cuadrada de 81 es 9?
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _Raiz
; Description ...: Hace una raíz. esta función es... obsoleta. Intenta buscar un número que multiplicado de sí mismo de igual al número de que obtenemos raíz, pero AutoIt tiene una función de eso :(. Es que de lo que me entero...
; Syntax ........: _Raiz($nRaiz, $nNum)
; Parameters ....: $nRaiz               - número de raíz a obtener: 2 cuadrada, 3 cúbica, etc.
;                  $nNum                - el número con que hacer la raíz.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Raiz($nRaiz, $nNum)
	Local $nMult = "0.100", $nResult = "", $nResult2 = ""
	If not IsNumber($nRaiz) and not IsNumber($nNum) then return SetError(1, 0, "")
	While 1
		$nMult = $nMult + 0.10
		For $I = 1 To $nRaiz
			$nResult &= $nMult & "*"
		Next
		$nResult = StringTrimRight($nResult, 1)
		$nResult2 = Round(Execute($nResult), 1)
		If $nResult2 = $nNum Then
			Return $nMult
			ExitLoop
		Else
			$nResult = ""
			;No es la respuesta, seguimos:
		EndIf
		Sleep(10) ;Simulando a un humano.
	WEnd
EndFunc   ;==>_Raiz
; #FUNCTION# ====================================================================================================================
; Name ..........: _Raiz2
; Description ...: Función de raíz que se usa en autoit. Se puede usar SQRT para raíz cuadrada, pero esta función permite realizar cúbica y otras.
; Syntax ........: _Raiz2($nRaiz, $nNum)
; Parameters ....: $nRaiz               - número de raíz a obtener: 2 cuadrada, 3 cúbica, etc.
;                  $nNum                - el número con que hacer la raíz.
; Return values .: La raíz.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _Raiz2($nRaiz, $nNum)
	If not IsNumber($nRaiz) and not IsNumber($nNum) then return SetError(1, 0, "")
	Return $nNum ^ (1 / $nRaiz)
EndFunc   ;==>_Raiz2
; #FUNCTION# ====================================================================================================================
; Name ..........: RaizObtenerRazon
; Description ...: Obtiene la razón de una raíz.
; Syntax ........: RaizObtenerRazon($nResult, $nRaiz)
; Parameters ....: $nResult             - El resultado de la raíz que se haya obtenido.
;                  $nRaiz               - 2 si fue cuadrada, 3 si fue cúbica, 4 cuarta... y así sucesivamente.
; Return values .: La razón de la raíz
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func RaizObtenerRazon($nResult, $nRaiz)
	If not IsNumber($nResult) and not IsNumber($nRaiz) then return SetError(1, 0, "")
	Local $aReason[2]
	Local $nProcess1 = "", $nProcess2 = ""
	For $I = 1 To $nRaiz
		$nProcess1 &= $nResult & "*"
	Next
	$nProcess1 = StringTrimRight($nProcess1, 1)
	$aReason[0] = $nProcess1
	$nProcess2 = Execute($nProcess1)
	$aReason[1] = $nProcess2
	Return $aReason
EndFunc   ;==>RaizObtenerRazon
; #FUNCTION# ====================================================================================================================
; Name ..........: RaizObtenerRazon2
; Description ...: Este es otro método para obtener la razón de una raíz.
; Syntax ........: RaizObtenerRazon2($nRaiz, $nNum)
; Parameters ....: $nRaiz               - La raíz. 2 = cuadrada, 3 = cúbica...
;                  $nNum                - el número que se va a hacer la raíz.
; Return values .: Una matriz que contiene los resultados de la razón.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func RaizObtenerRazon2($nRaiz, $nNum)
	If not IsNumber($nRaiz) and not IsNumber($nNum) then return SetError(1, 0, "")
	Local $aReason[2]
	Local $nProcess1 = $nNum & "/", $nProcess2 = ""
	For $I = 1 To $nRaiz
		$nProcess1 &= $nRaiz & "/"
	Next
	$nProcess1 = StringTrimRight($nProcess1, 1)
	$aReason[0] = $nProcess1
	$nProcess2 = Execute($nProcess1)
	$aReason[1] = $nProcess2
	Return $aReason
EndFunc   ;==>RaizObtenerRazon2
