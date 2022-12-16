#include-once

Func Complex($Real, $Imag)
	Local $ret[2] = [$Real, $Imag]

	Return $ret
EndFunc

Func ComplexReal($C)
	Return $C[0]
EndFunc

Func ComplexImag($C)
	Return $C[1]
EndFunc

Func ComplexNegate($C)
	Return Complex(-$C[0], -$C[1])
EndFunc

Func ComplexAbs($C)
	Return Sqrt($C[0]^2 + $C[1]^2)
EndFunc

Func ComplexArg($C)
	Return AngleBetweenPoints(Point(), $C)
EndFunc

Func ComplexConj($C)
	Return Complex($C[0], -$C[1])
EndFunc

Func ComplexAdd($C1, $C2)
	Return Complex($C1[0]+$C2[0], $C1[1]+$C2[1])
EndFunc

Func ComplexSubtract($C1, $C2)
	Return Complex($C1[0]-$C2[0], $C1[1]-$C2[1])
EndFunc

Func ComplexMultiply($C1, $C2)
	Return Complex($C1[0]*$C2[0] - $C1[1]*$C2[1], $C1[0]*$C2[1] + $C1[1]*$C2[0])
EndFunc

Func ComplexDivide($C1, $C2)
	Complex(($C1[0]*$C2[0] + $C1[1]*$C2[1])/(ComplexArg($C2)^2), ($C1[0]*$C2[1] - $C1[1]*$C2[0])/(ComplexArg($C2)^2))
EndFunc

Func ComplexExp($C)
	Return Complex(Exp($C[0])*Cos($C[1]), Exp($C[0])*Sin($C[1]))
EndFunc

Func ComplexLog($C)
	Return Complex(Log(ComplexAbs($C)), ComplexArg($C))
EndFunc

Func ComplexPow($C1, $C2)
	Return ComplexExp(ComplexMultiply($C2, ComplexLog($C1)))
EndFunc
