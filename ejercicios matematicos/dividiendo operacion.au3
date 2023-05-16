#include <array.au3>
#include "..\Include\mymath\misc.au3"

Local $sInput = "15/150*100"
Local $AOutput = _split_math_operators($sInput)
_arraydisplay($aOutput)
For $i = 0 To UBound($aOutput) - 2 step 2
    ConsoleWrite("Número: " & $aOutput[$i] & ", Operador: " & $aOutput[$i + 1] & @CRLF)
Next
consoleWrite("¡Finalizado!")