; Creador de operaciones muy cool.
; #FUNCTION# ====================================================================================================================
; Name ..........: generarOperacion
; Description ...:
; Syntax ........: generarOperacion($sOperador[, $iModo = 2[, $iMultDificult = 1]])
; Parameters ....: $sOperador           - a string value.
;                  $iModo               - [optional] an integer value. Default is 2.
;                  $iMultDificult       - [optional] an integer value. Default is 1.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func generarOperacion($sOperador, $iModo = 2, $iMultDificult = 1)
if not IsString($sOperador) then Return setError(1, 0, "")
if not $sOperador = "+" or not $sOperador = "-" or not $sOperador = "*" then Return SetError(2, 0, "")
If not IsInt($iModo) or Not IsInt($iMultDificult) then Return SetError(3, 0, "")
if $iMultDificult > 3 then Return SetError(4, 0, "")
local $nPrimerTermino, $nSegundoTermino, $nRango, $iDificultad
; aremos una especie de rangos para los modos.
$nRango = _GenerarRango($iModo)
; ahora convertimos ese rango en una matriz separando el mínimo y el máximo para ponerlos en una columna.
$aRango = StringSplit($nRango, "-")
Select
case $sOperador = "-" or $sOperador = "+"
; generamos el primer término de acuerdo al rango:
$nPrimerTermino = int(Random($aRango[1], $aRango[2]))
; segundo término:
$nSegundoTermino = int(Random($aRango[1], $nPrimerTermino))
case $sOperador = "*"
$nPrimerTermino = int(Random($aRango[1], $aRango[2]))
; aquí tomamos en cuenta el $iMultDificult:
$iDificultad = int(StringLen($nPrimerTermino)*$iMultDificult/3)
if $iDificultad = 0 or StringLen($iDificultad) >1 then
local $aNuevoRango = ["", 1, 9]
Else
$aNuevoRango = StringSplit(_GenerarRango($iDificultad), "-")
EndIf
$nSegundoTermino = int(Random($aNuevoRango[1], $aNuevoRango[2]))
if $nSegundoTermino > $nPrimerTermino then $nSegundoTermino = int($nSegundoTermino - $nPrimerTermino)
EndSelect
; finalmente, hacemos que la función retorne la operación generada. Así, ¡Cuando llames a la función te dará esa resta y deberías aplicarla para ver su igual! No se vale hacer trampas, como usar la función execute. Bueno, se puede usar, pero hmm no en ese plan de trampa.
return $nPrimerTermino &$sOperador &$nSegundoTermino
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _GenerarRango
; Description ...:
; Syntax ........: _GenerarRango($iMode)
; Parameters ....: $iMode               - an integer value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _GenerarRango($iMode)
if $iMode <1 then return SetError(1, 0, "")
local $iStart = 1, $iEnd = 9
local $sRango = ""
$sRango = $iStart
if $iMode > 1 then
For $I = 0 to $iMode -2
$sRango &= "0"
Next
EndIf
$sRango &= "-"
For $I = 0 to $iMode -1
$sRango &= $iEnd
Next
return $sRango
EndFunc