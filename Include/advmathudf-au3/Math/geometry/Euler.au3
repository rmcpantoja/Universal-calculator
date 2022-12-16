#include-once

Func EulerRotateX($Vector, $Origin, $Angle = 0)
	Local $Vec = VectorSubtract($Vector, $Origin)
	Local $Matrix = [[1, 0, 0], _
					[0, Cos($Angle), -Sin($Angle)], _
					[0, Sin($Angle), Cos($Angle)]]

	$Vec = MultiplyArrayByMatrix($Vec, $Matrix)

	Return VectorAdd($Vec, $Origin)
EndFunc

Func EulerRotateY($Vector, $Origin, $Angle = 0)
	Local $Vec = VectorSubtract($Vector, $Origin)
	Local $Matrix = [[Cos($Angle), 0, Sin($Angle)], _
					[0, 1, 0], _
					[-Sin($Angle), 0, Cos($Angle)]]

	$Vec = MultiplyArrayByMatrix($Vec, $Matrix)

	Return VectorAdd($Vec, $Origin)
EndFunc

Func EulerRotateZ($Vector, $Origin, $Angle = 0)
	Local $Vec = VectorSubtract($Vector, $Origin)
	Local $Matrix = [[Cos($Angle), -Sin($Angle), 0], _
					[Sin($Angle), Cos($Angle), 0], _
					[0, 0, 1]]

	$Vec = MultiplyArrayByMatrix($Vec, $Matrix)

	Return VectorAdd($Vec, $Origin)
EndFunc