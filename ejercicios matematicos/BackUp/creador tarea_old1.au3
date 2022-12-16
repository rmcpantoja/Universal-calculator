; creador de tarea:
#include "array.au3"
#include "include\generador_operaciones.au3"
global $sOperators
$sOperators = "+-*/^"
main()
; #FUNCTION# ====================================================================================================================
; Name ..........: Main
; Description ...: Función principal para este pequeño programa.
; Syntax ........: Main()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func Main()
local $aTarea, $aOperadores
local $bPlural = False
local $hFile
local $nNivel
local $sDeCadaUno = ""
local $vMiOperacion = ""
$nNivel = number(InputBox("Nivel", "¿De qué nivel quieres esta tarea? (1 a 3)"))
if @error then
msgbox(16, "Error", "Debes escribir el nivel para proceder")
Exit
EndIf
$aTarea = _CrearTarea($nNivel)
if @error then
msgbox(16, "Error al realizar la tarea", @error)
Exit
EndIf
; identificar qué operaciones hay y de qué tipos son:
$aOperadores = _count_homework_Operators($aTarea)
$sDeCadaUno &= uBound($aTarea) &" diferentes operaciones en total. En esta tarea te he dado " &uBound($aOperadores, 1) &" tipos que son: "
For $I = 0 to uBound($aOperadores, 1) -1
if not $I = uBound($aOperadores, 1) -1 then $sDeCadaUno &= $aOperadores[$I][0] & " "
if $aOperadores[$I][0] = 1 then
$bPlural = False
Else
$bPlural = True
EndIf
if not $I = uBound($aOperadores, 1) -1 then
$sDeCadaUno &= _Operator_GetName($aOperadores[$I][1], $bPlural) &", "
Else
$sDeCadaUno &= " y " &$aOperadores[$I][0] &" " &_Operator_GetName($aOperadores[$I][1], $bPlural) &"."
EndIf
Next
$hFile = FileOpen(@ScriptDir &"\tarea de " &uBound($aTarea) &" operaciones.txt", 1)
FileWrite($hFile, "Tarea matemática" &@crlf &"La tarea tiene: " &$sDeCadaUno &@crlf &"Resuelva las siguientes operaciones:" &@crlf)
FileWrite($hFile, _ArrayToString($aTarea, @crlf))
FileClose($hFile)
MsgBox(0, "éxito", "He creado una tarea. Puedes revisarla y realizarla.")
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _CrearTarea
; Description ...:
; Syntax ........: _CrearTarea($nNivel)
; Parameters ....: $nNivel              - a general number value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _CrearTarea($nNivel)
; 1 fácil, 2 intermedio, 3 difícil
local $aOperaciones[0]
local $iCuantas
local $sOperador
if not IsNumber($nNivel) then Return SetError(1, 0, "")
switch $nNivel
case 1
$iCuantas = Random(3, 10, 1)
Case 2
$iCuantas = Random(10, 25, 1)
Case 3
$iCuantas = Random(25, 50, 1)
EndSwitch
For $I = 0 to $iCuantas -1
$sOperador = _GenerateOperator(random(1, 3, 1))
$sOperacion = generarOperacion($sOperador, int(_dificultades($nNivel)), int($nNivel))
if @error then
return SetError(2, 0, "")
ExitLoop
EndIf
ReDim $aoperaciones[ubound($aOperaciones) +1]
$aOperaciones[$I] = $sOperacion
Next
return $aOperaciones
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _dificultades
; Description ...:
; Syntax ........: _dificultades($iDif)
; Parameters ....: $iDif                - an integer value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _dificultades($iDif)
local $iResult
if not IsInt($iDif) then Return SetError(1, 0, "")
switch $iDif
case 1
$iResult = random(1, 2)
case 2
$iResult = random(2, 4)
case 3
$iResult = random(4, 6)
EndSwitch
return $iResult
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _GenerateOperator
; Description ...:
; Syntax ........: _GenerateOperator($iOperator)
; Parameters ....: $iOperator           - an integer value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GenerateOperator($iOperator)
if $iOperator > 5 then Return SetError(1, 0, "")
local $aOperator = ["+", "-", "*", "/", "^"]
return $aOperator[$iOperator-1]
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _Operator_GetName
; Description ...:
; Syntax ........: _Operator_GetName($sOperator[, $bPlural = False])
; Parameters ....: $sOperator           - a string value.
;                  $bPlural             - [optional] a boolean value. Default is False.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Operator_GetName($sOperator, $bPlural = False)
local $aNames[] = ["suma", "resta", "multiplicación", "división", "potencia"]
local $aOperator = ["+", "-", "*", "/", "^"]
local $sCurrent
if not IsString($sOperator) then Return SetError(1, 0, "")
For $I = 0 to uBound($aNames) -1
If $aOperator[$I] = $sOperator then
if $bPlural Then
If StringInStr($aNames[$i], "ón") then
Return StringReplace($aNames[$i], "ón", "ones")
Else
Return $aNames[$i] &"s"
EndIf
Else
Return $aNames[$i]
EndIf
ExitLoop
EndIf
Next
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _operation_getOperator
; Description ...:
; Syntax ........: _operation_getOperator($sOperation)
; Parameters ....: $sOperation          - a string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _operation_getOperator($sOperation)
local $iLen
local $sCurrent
if Not IsString($sOperation) then Return SetError(1, 0, "")
$iLen = StringLen($sOperation)
if $iLen > 24 then Return SetError(2, 0, "")
For $I = 1 to $iLen
$sCurrent = StringMid($sOperation, $i, 1)
if StringInStr($sOperators, $sCurrent) then
return $sCurrent
ExitLoop
EndIf
Next
Return SetError(3, 0, "")
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _count_homework_Operators
; Description ...:
; Syntax ........: _count_homework_Operators($aHomework)
; Parameters ....: $aHomework           - an array of unknowns.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _count_homework_Operators($aHomework)
local $iResult
local $sCurrent, $sHomework, $sCurrentOperators
if not IsArray($aHomework) then Return SetError(1, 0, "")
local $aResults[0][2]
$sHomework = _ArrayToString ($aHomework)
$sCurrentOperators = _regexOcurrence($sHomework, "|1234567890")
for $I = 0 to stringLen($sOperators) -1
$sCurrent = StringMid($sOperators, $i+1, 1)
$iResult = int(_get_number_of_ocurrences($sCurrentOperators, $sCurrent))
if not $iResult = 0 then
ReDim $aResults[uBound($aResults, 1)+1][uBound($aResults, 2)]
$aResults[$I][0] = $iResult
$aResults[$I][1] = $sCurrent
EndIf
next
return $aResults
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _get_number_of_ocurrences
; Description ...:
; Syntax ........: _get_number_of_ocurrences($sText, $sChar)
; Parameters ....: $sText               - a string value.
;                  $sChar               - a string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _get_number_of_ocurrences($sText, $sChar)
Return StringLen($sText) - StringLen(StringReplace($sText, $sChar, ''))
EndFunc ;==>_Occurrence1
; #FUNCTION# ====================================================================================================================
; Name ..........: _regexOcurrence
; Description ...:
; Syntax ........: _regexOcurrence($sText, $sRegEx)
; Parameters ....: $sText               - a string value.
;                  $sRegEx              - a string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _regexOcurrence($sText, $sRegEx)
local $sResult = StringRegExpReplace($sText, "[" &$sRegex &"]", '')
return $sResult
EndFunc