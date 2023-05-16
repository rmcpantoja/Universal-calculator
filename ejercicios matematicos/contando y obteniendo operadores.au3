#include <array.au3>
#include "..\Include\mymath\misc.au3"

; example:
$aCountResult = _count_math_Operators("2+2+2-1")
_arraydisplay($aCountResult)
$aOperators = _get_math_Operators("2+2+2-1")
_arraydisplay($aOperators)
