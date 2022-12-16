#include-once

Func Vector($x = 0, $y = 0, $z = 0)
	Local $arr = [$x, $y, $z]
	Return $arr
EndFunc

Func VectorAdd($Vec1, $Vec2)
	If Not IsArray($Vec2) Then $Vec2 = Vector($Vec2, $Vec2, $Vec2)
	Return Vector($Vec1[0]+$Vec2[0], $Vec1[1]+$Vec2[1], $Vec1[2]+$Vec2[2])
EndFunc

Func VectorSubtract($Vec1, $Vec2)
	If Not IsArray($Vec2) Then $Vec2 = Vector($Vec2, $Vec2, $Vec2)
	Return Vector($Vec1[0]-$Vec2[0], $Vec1[1]-$Vec2[1], $Vec1[2]-$Vec2[2])
EndFunc

Func VectorMultiplyScalar($Vec, $fNum)
	Return Vector($Vec[0]*$fNum, $Vec[1]*$fNum, $Vec[2]*$fNum)
EndFunc

Func VectorDivideScalar($Vec, $fNum)
	Return Vector($Vec[0]/$fNum, $Vec[1]/$fNum, $Vec[2]/$fNum)
EndFunc

Func VectorNegate($Vec)
	Return Vector(-$Vec[0], -$Vec[1], -$Vec[2])
EndFunc

Func VectorApplyOp($Vec, $fnFunction, $bPassAdditionalParams = False)
	If IsFunc($fnFunction) Then $fnFunction = FuncName($fnFunction)

	Return $bPassAdditionalParams ? Vector(Call($fnFunction, $Vec[0], 0, $Vec), Call($fnFunction, $Vec[1], 1, $Vec), Call($fnFunction, $Vec[2], 2, $Vec)) : Vector(Call($fnFunction, $Vec[0]), Call($fnFunction, $Vec[1]), Call($fnFunction, $Vec[2]))
EndFunc

Func VectorDotProduct($Vec1, $Vec2)
	Return $Vec1[0]*$Vec2[0] + $Vec1[1]*$Vec2[1] + $Vec1[2]*$Vec2[2]
EndFunc

Func VectorCross($Vec1, $Vec2)
	Return Vector($Vec1[1]*$Vec2[2] - $Vec1[2]*$Vec2[1], _
				$Vec1[2]*$Vec2[0] - $Vec1[0]*$Vec2[2], _
				$Vec1[0]*$Vec2[1] - $Vec1[1]*$Vec2[0])
EndFunc

Func VectorLength($Vec)
	Return Sqrt($Vec[0]^2 + $Vec[1]^2 + $Vec[2]^2)
EndFunc

Func VectorNormalize($Vec)
	Local $len = VectorLength($Vec)
	If $len = 0 Then Return Vector(0, 0, 0)

	Return Vector($Vec[0]/$len, $Vec[1]/$len, $Vec[2]/$len)
EndFunc

Func VectorAngleBetween($Vec1, $Vec2)
	Return ACos(VectorDotProduct(VectorNormalize($Vec1), VectorNormalize($Vec2)))
EndFunc

Func VectorReflect($Vec, $Normal)
	If VectorLength($Normal) <> 1 Then $Normal = VectorNormalize($Normal)

	Return VectorSubtract(VectorMultiplyScalar($Normal, VectorDotProduct($Normal, $Vec)*2), $Vec)
EndFunc

Func VectorTransmit($Vec, $Normal, $IOR = 1)
	Local $bInvert = ($IOR < 0) ? True : False
	$IOR = Abs($IOR)

	Local $toCameraDir = VectorNegate($Vec)
	Local $cosIncidentAngle = VectorDotProduct(VectorNormalize($Normal), $toCameraDir)
	Local $eta = ($cosIncidentAngle > 0) ? $IOR : (1 / $IOR)
	Local $refractionCoeff = 1 - (1 - $cosIncidentAngle * $cosIncidentAngle) / ($eta * $eta)

	If $cosIncidentAngle < 0 Then
		$Normal = VectorNegate($Normal)
		$cosIncidentAngle = -$cosIncidentAngle
	EndIf

	Local $vecRet = VectorSubtract(VectorDivideScalar(VectorNegate($toCameraDir), $eta), VectorMultiplyScalar($Normal, (Sqrt($refractionCoeff) - $cosIncidentAngle) / $eta))

	Return $bInvert ? VectorReflect($vecRet, VectorNegate($Normal)) : $vecRet
EndFunc

Func VectorDistance($Vec1, $Vec2)
	Return Sqrt(($Vec1[0]-$Vec2[0])^2 + ($Vec1[1]-$Vec2[1])^2 + ($Vec1[2]-$Vec2[2])^2)
EndFunc
