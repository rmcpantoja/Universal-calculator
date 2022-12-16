#include-once

Func Quaternion($a = 0, $b = 0, $c = 0, $d = 0)
	Local $arr = [$a, $b, $c, $d]
	Return $arr
EndFunc

Func QuaternionGetVector($q)
	Return Vector($q[1], $q[2], $q[3])
EndFunc

Func QuaternionFromScalarVectorPair($Scalar, $Vec)
	Return Quaternion($Scalar, $Vec[0], $Vec[1], $Vec[2])
EndFunc

Func QuaternionConj($q)
	Return Quaternion($q[0], -$q[1], -$q[2], -$q[3])
EndFunc

Func QuaternionNorm($q)
	Return Sqrt($q[0]^2 + $q[1]^2 + $q[2]^2 + $q[3]^2)
EndFunc

Func QuaternionAdd($q1, $q2)
	Return Quaternion($q1[0]+$q2[0], $q1[1]+$q2[1], $q1[2]+$q2[2], $q1[3]+$q2[3])
EndFunc

Func QuaternionSubtract($q1, $q2)
	Return Quaternion($q1[0]-$q2[0], $q1[1]-$q2[1], $q1[2]-$q2[2], $q1[3]-$q2[3])
EndFunc

Func QuaternionMultiply($q1, $q2)
	Local $Vec1 = QuaternionGetVector($q1)
	Local $Vec2 = QuaternionGetVector($q2)

	Local $Scalar = $q1[0]*$q2[0] - VectorDotProduct($Vec1, $Vec2)
	Local $Vector = VectorAdd(VectorAdd(VectorMultiplyScalar($Vec2, $q1[0]), VectorMultiplyScalar($Vec1, $q2[0])), VectorCross($Vec1, $Vec2))

	Return QuaternionFromScalarVectorPair($Scalar, $Vector)
EndFunc

Func QuaternionInvert($q)
	$NormSq = QuaternionNorm($q)^2
	$qc = QuaternionConj($q)

	Return QuaternionMultiply($qc, Quaternion(1/$NormSq))
EndFunc

Func QuaternionDivide($q1, $q2)
	Return QuaternionMultiply($q1, QuaternionInvert($q2))
EndFunc

Func QuaternionRotateVector($Vec, $Q)
	Return QuaternionGetVector(QuaternionMultiply(QuaternionMultiply($Q, QuaternionFromScalarVectorPair(0, $Vec)), QuaternionConj($Q)))
EndFunc
