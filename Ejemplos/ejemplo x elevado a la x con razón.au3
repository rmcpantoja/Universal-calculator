#include "include\elevar.au3"
$nNum = 7
$nEstoElevar = 7
$aResultados = _Elevado($nNum, $nEstoElevar, true)
MsgBox(0, "Resultados de " &$nNum & " elevado a la " &$nEstoElevar, "Respuesta: " &$aResultados[0] &@crlf &"Razón: porque " &$aResultados[1])