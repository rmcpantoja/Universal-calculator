#include-once

Func NSimplexNum($n, $r)
	Return Newton($n + $r - 1, $r)
EndFunc

Func PolygonalNum($n, $s)
	Return (($n*$n)*($s-2) - $n*($s-4))/2
EndFunc

Func TriangularNum($n)
	Return PolygonalNum($n, 3)
EndFunc

Func HexagonalNum($n)
	Return PolygonalNum($n, 6)
EndFunc