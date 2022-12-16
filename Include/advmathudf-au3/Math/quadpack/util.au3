#include-once

Func __QuadpackRescaleError($fErr, $fResabs, $fResasc)
	Local $err = Abs($fErr)

	If $fResasc <> 0 And $err <> 0 Then
		Local $scale = (200*$err/$fResasc)^1.5

		If $scale < 1 Then
			$err = $fResasc*$scale
		Else
			$err = $fResasc
		EndIf
	EndIf
	If $fResabs > (2.2250738585072014e-308/(50*2.2204460492503131e-16)) Then
		Local $min_err = 50*2.2204460492503131e-16*$fResabs
		If $min_err > $err Then $err = $min_err
	EndIf

	Return $err
EndFunc

Func __QuadpackTestPositivity($fResult, $fResabs)
	Return Abs($fResabs) >= ((1 - 50*2.2204460492503131e-16)*$fResabs)
EndFunc