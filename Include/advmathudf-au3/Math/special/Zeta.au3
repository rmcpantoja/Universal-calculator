#include-once

Func RiemannZeta($x, $maxIt = 10000)
	Local $sum = 0, $it = 1, $last = 0

	Do
		$last = 1/($it^$x)
		$sum += $last
		$it += 1
	Until $last < 1e-16 Or $it > $maxIt

	Return $sum
EndFunc

Func RiemannXi($x)
	Return 0.5*$x*($x-1)*Gamma(0.5*$x)*RiemannZeta($x)*$Pi^(-$x/2)
EndFunc

Func DirichletEta($x)
	Return (1-2^(1-$x))*RiemannZeta($x)
EndFunc

Func HurwitzZeta($x, $q, $maxIt = 10000)
	Local $sum = 0, $it = 0, $last = 0

	Do
		$last = 1/(($q+$it)^$x)
		$sum += $last
		$it += 1
	Until $last < 1e-16 Or $it > $maxIt

	Return $sum
EndFunc

Func LegendreChi($x, $v, $maxIt = 10000)
	Local $sum = 0, $it = 0, $last = 0

	Do
		$last = ($x^(2*$it+1))/((2*$it+1)^$v)
		$sum += $last
		$it += 1
	Until $last < 1e-16 Or $it > $maxIt

	Return $sum
EndFunc

Func DirichletLambda($x)
	Return (1-2^(-$x))*RiemannZeta($x)
EndFunc