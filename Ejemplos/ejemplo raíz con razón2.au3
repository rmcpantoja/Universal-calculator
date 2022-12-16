#include "include\Raiz.au3"
;MsgBox(0, "Hola", "soy una persona y voy a resolver la raíz cuadrada de 64. Presiona aceptar cuando quieras que comience a procesar. Solo te pido, por favor tenme paciencia... :(")
$nRaiz = 4
$nNum = 1024
;$nResultado = _Raiz($nRaiz, $nNum)
$nResultado = 4
$aPorQue = RaizObtenerRazon2($nRaiz, $nNum)
MsgBox(0, "La raíz cuadrada de " &$nNum &" es", $nResultado &", porque " & $aPorQue[0] &" es igual a " &$aPorQue[1] &". Si me he equivocado lo siento, la próxima lo volveré a hacer, lo prometo.")
