#include-once

Func Cosh($x)
	Return ($E^$x + $E^(-$x))/2
EndFunc

Func Coth($x)
	Return Cosh($x)/Sinh($x)
EndFunc

Func Csch($x)
	Return 1/Sinh($x)
EndFunc

Func Sech($x)
	Return 1/Cosh($x)
EndFunc

Func Sinh($x)
	Return ($E^$x - $E^(-$x))/2
EndFunc

Func Tanh($x)
	Return Sinh($x)/Cosh($x)
EndFunc

Func ACosh($x)
	Return Log($x+Sqrt($x-1)*Sqrt($x+1))
EndFunc

Func ACoth($x)
	Return Log(Sqrt(($x+1)/($x-1)))
EndFunc

Func ACsch($x)
	Return Log(Sqrt(1+1/$x^2)+1/$x)
EndFunc

Func ASech($x)
	Return Log(Sqrt(1/$x-1)*Sqrt(1/$x+1)+1/$x)
EndFunc

Func ASinh($x)
	Return Log($x+Sqrt($x^2+1))
EndFunc

Func ATanh($x)
	Return Log((Sqrt(1-$x^2))/(1-$x))
EndFunc