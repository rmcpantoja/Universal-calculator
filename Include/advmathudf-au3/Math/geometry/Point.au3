#include-once

Func Point($x = 0, $y = 0)
	Return Vector($x, $y, 0)
EndFunc

Func RotatePoint($Point, $Origin, $Angle)
	$d = Sqrt($Point[0]^2+$Point[1]^2)
	$ang = AngleBetweenPoints($Origin, $Point)
	$ang += $Angle

	$iX = $d * Cos($ang)
	$iY = $d * Sin($ang)

	Return Point($iX, $iY)
EndFunc

Func AngleBetweenPoints($Point1, $Point2)
	Local $x, $y, $d, $and

	$x = $Point2[0]-$Point1[0]
	$y = $Point2[1]-$Point1[1]
	$d = Sqrt($x^2+$y^2)
	$ang = ASin($y/$d)
	If $x < 0 And $y > 0 Then
		$ang = _Radian(90)+(_Radian(90)-Abs($ang))
	ElseIf $x < 0 And $y < 0 Then
		$ang = _Radian(-180)+Abs($ang)
	ElseIf $x < 0 And $y = 0 Then
		$ang = _Radian(180)
	EndIf

	Return $ang
EndFunc

Func DistanceBetweenPoints($Point1, $Point2)
	Return VectorDistance($Point1, $Point2)
EndFunc