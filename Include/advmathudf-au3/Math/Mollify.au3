#include-once

Func Mollify($fnFunc, $fX, $fnMollifier, $fRadius = 1, $fStep = 0.02)
	If IsFunc($fnFunc) Then $fnFunc = FuncName($fnFunc)
	If IsFunc($fnMollifier) Then $fnMollifier = FuncName($fnMollifier)
	Local $fResult, $fSum = 0
	Local $x, $c

	For $x = -1 To 1 Step $fStep
		$c = Call($fnMollifier, $x)
		$fResult += Call($fnFunc, $fX+$x*$fRadius)*$c
		$fSum += $c
	Next
	$fResult /= $fSum

	Return $fResult
EndFunc

Func BellCurveMollifier($f)
	Return BellCurve($f, 1, 0, 0.5)
EndFunc

Func LinearMollifier($f)
	If Abs($f) > 1 Then Return 0
	Return 1-Abs($f)
EndFunc

Func ConstantMollifier($f)
	If Abs($f) > 1 Then Return 0
	Return 1
EndFunc

Func SharpMollifier($f)
	If Abs($f) > 1 Then Return 0
	Return (1-Abs($f))^2
EndFunc