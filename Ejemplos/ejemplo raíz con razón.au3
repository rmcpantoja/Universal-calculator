#include "include\Raiz.au3"
;MsgBox(0, "Hola", "soy una persona y voy a resolver la raíz cuadrada de 64. Presiona aceptar cuando quieras que comience a procesar. Solo te pido, por favor tenme paciencia... :(")
$nRaiz = 2
$nNum = 64
;$nResultado = _Raiz($nRaiz, $nNum)
$nResultado = 8
$aPorQue = RaizObtenerRazon($nResultado, $nRaiz)
MsgBox(0, "La raíz cuadrada de " &$nNum &" es", $nResultado &", porque " & $aPorQue[0] &" es igual a " &$aPorQue[1] &". Si me he equivocado lo siento, la próxima lo volveré a hacer, lo prometo.")
