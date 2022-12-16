; script con el propósito de ayudar.
; ------------------------------
; establecemos una variable que la usaremos para manipular cuántas restas va a generar. En este caso ará 20 restas totalmente diferentes.
; es mmuy útil cuando quieres mandar una tarea para que alguien elavore x restas.
$iRestas = 20
; establecemos una variable de otro tipo (cadena) para almacenar la resta generada:
$sResultado = ""
; ahora hacemos un bucle del 1 al número de restas de la variable $iRestas:
For $I = 1 to $iRestas
; aquí aprobechamos haciendo las restas que se hayan querido, el número de restas establecido por la variable.
; iniciamos la variable $sResultado donde llamamos a una función para generar una resta, y lo que devuelva esa función será la resta generada que se guardará en esta variable. En este caso, quiero generar una resta de decenas de mil.
$sResultado = generarResta(5)
; mostramos un diálogo con la resta generada:
MsgBox(0, "Resta #" &$i, $sResultado)
Next
; se acabó el bucle. Ahora mostramos el mensaje para indicar el final.
MsgBox(0, "éxito", "¡Las restas se an generado satisfactoriamente! ¿Me contratarías como profesor de matemáticas? ¡Seguro ayudaría mucho a pesar que soy una máquina!")
; la siguiente función es la que genera una resta:
func generarResta($iMode = 2)
; el parámetro $iMode = 2 en este caso será el tipo de resta, ej. 1 = unidades, 2 = decenas, 3 = centenas... y así hasta 9.
; declararemos las variables que se usarán y a su vez es fácil de entenderlas:
local $nMinuendo, $nSustraendo, $nRango
; aremos una especie de rangos para los nueve modos.
switch $iMode
case 1
$nRango = "1-9"
case 2
$nRango = "10-90"
case 3
$nRango = "100-999"
case 4
$nRango = "1000-9999"
case 5
$nRango = "10000-99999"
case 6
$nRango = "100000-999999"
case 7
$nRango = "1000000-9999999"
case 8
$nRango = "10000000-99999999"
case 9
$nRango = "100000000-999999999"
EndSwitch
; ahora convertimos ese rango en una matriz separando el mínimo y el máximo para ponerlos en una columna.
$aRango = StringSplit($nRango, "-")
; generamos el minuendo de acuerdo al rango:
$nMinuendo = int(Random($aRango[1], $aRango[2]))
; generamos el sustraendo. El rango del sustraendo es diferente, en este caso partimos desde el mínimo del rango establecido hasta el máximo que tiene el minuendo, y ya no del establecido.
; esto por la condición de que el sustraendo debe ser menor al minuendo y la debemos cumplir para obtener una buena resta.
$nSustraendo = int(Random($aRango[1], $nMinuendo))
; finalmente, hacemos que la función retorne la resta, es decir, el minuendo y el sustraendo ya generados. Así, ¡Cuando llames a la función te dará esa resta y deberías aplicarla para ver su igual! No se vale hacer trampas, como usar la función execute. Bueno, se puede usar, pero hmm no en ese plan de trampa.
return $nMinuendo &"-" &$nSustraendo
EndFunc