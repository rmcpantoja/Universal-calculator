#include "include\funciones aritmeticas.au3"
;Este script demuestra ejemplos del uso y estracción de todas las funciones aritméticas, esto es posible gracias a la UDF que escribí y que acabamos de incluir en la línea anterior.
MsgBox(0, "Progresiones aritméticas: obteniendo el primer término", _a1(10, 5, 2))
MsgBox(0, "Progresiones aritméticas: Ahora obtenemos la diferencia", _Diference(10, 2, 5))
MsgBox(0, "Progresión aritmética: ahora sacaremos el número de término (n)", _NumTerm(10, 2, 2))
MsgBox(0, "Progresión aritmética: Obteniendo el término enésimo o último término", _An(2, 5, 2))
MsgBox(0, "Progresión aritmética: Obteniendo la suma de los términos (método uno)", _Sn1(10, 2, 5))
MsgBox(0, "Progresión aritmética: Obteniendo la suma de los términos (método dos)", _Sn2(5, 2, 2))
