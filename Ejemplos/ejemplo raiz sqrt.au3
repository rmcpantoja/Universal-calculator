#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable the square-root of 2.
	Local $fSqrt1 = Sqrt(2)
MsgBox(4096, "The cube root of 27 is", 27 ^ (1/3))
	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $fSqrt1)

	; Assign a Local variable the square-root of 9.
	Local $fSqrt2 = Sqrt(9)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $fSqrt2)
EndFunc   ;==>Example
