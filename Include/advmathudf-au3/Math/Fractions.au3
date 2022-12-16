#include-once

Func ContinuedFraction($f, $depth = 10)
	Local $arr[0], $rec = 0, $ret = ""
	If $f = 0 Then
		Return 0
	Else
		Do
			$a = Int($f)
			_ArrayAdd($arr, $a)
			If $f-$a = 0 Then ExitLoop
			$f = 1/($f-$a)
			If $f < -225179981368524 Then ExitLoop
			If $f > 28147497671064 Then
				ExitLoop
			EndIf
			$rec += 1
		Until $rec = $depth

		Return $arr
	EndIf
EndFunc