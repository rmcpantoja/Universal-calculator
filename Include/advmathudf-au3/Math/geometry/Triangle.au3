#include-once

Func Triangle($a, $b, $c)
	Return Vector($a, $b, $c)
EndFunc

Func TriangleGetAngles($aTriangle)
	$alpha = ACos(-($aTriangle[0]^2 - $aTriangle[1]^2 - $aTriangle[2]^2)/($aTriangle[1]*$aTriangle[2]*2))
	$beta = ACos(-($aTriangle[1]^2 - $aTriangle[0]^2 - $aTriangle[2]^2)/($aTriangle[0]*$aTriangle[2]*2))
	$gamma = ACos(-($aTriangle[2]^2 - $aTriangle[1]^2 - $aTriangle[0]^2)/($aTriangle[1]*$aTriangle[0]*2))

	Return Vector($alpha, $beta, $gamma)
EndFunc