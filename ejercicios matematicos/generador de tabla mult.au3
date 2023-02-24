; write multiplying table/hacer tabla de multiplicación
;#include <array.au3>
#include <AutoItConstants.au3>
; declarando variables:
Local $aMult
Local $hFile
Local $sResult
; iniciando la variable $hFile, llamando a una función para abrir/crear archivo.
; creamos un archivo tabla de multiplicar.txt en la ubicación del script:
$hFile = FileOpen(@ScriptDir & "\tabla de multiplicar.txt", 1)
; escribir la primera línea en este nuevo archivo:
FileWriteLine($hFile, "Tabla de multiplicaciones:")
; en este caso vamos a hacer una tabla de 12 por 12, así que creamos un primer bucle.
For $I = 1 To 12
	; dentro de este bucle escribiremos en la siguiente línea del archivo: tabla del $i. $I es el número donde se encuentra el bucle, así que lo podemos interpretar como tabla del 1, tabla del 2, etc.
	FileWriteLine($hFile, "Tabla del " & $I & ":")
	; creamos la tabla de multiplicación acorde al número del bucle. Por ejemplo, si el bucle $I es 1, creará la tabla del 1.
	$aMult = _table($I)
	; creamos un segundo bucle dnetro del primer bucle. Un poco complicado ¿No? No te preocupes, voy a guiarte:
	For $j = 1 To 12
		; bien, estamos dentro de este segundo bucle. En este lo que aremos es manipular la tabla de multiplicación que creamos en el primer bucle.
		; en este caso, vamos a almacenar la variable $sResult con lo siguiente: Vamos a explicar paso por paso:
		$sResult = $aMult[$j - 1][0] & "*" & $aMult[$j - 1][1]
		; explicación:
		; $aMult[$j-1][0]: esta es la fila j columna 0. En la columna 0 de cualquier fila j tenemos el multiplicando. En este caso, j recorrerá de 1 a 12.
		; &: concatenador. Significa la unión con otras variables, funciones, cadenas etc, cuando establecemos una variable o llamamos a una funcion.
		; "*": Después de almacenar el multiplicando, hacemos una concatenación, es decir, le agregamos el signo multiplicar (*).
		; $aMult[$j-1][1]: ahora, volvemos a concatenar, almacenamos una parte de la tabla como cuando lo hicimos en la primera vez. La diferencia es que en lugar de la columna 0, usamos la columna 1. Ya que, fila j columna 1 tiene el multiplicador, y anteriormente fila j columna 0 contiene los multiplicandos. Así mismo, j va de 1 a 12.
		; lo siguiente es un comentario, pero se puede descomentar si quieres que te muestre mensajes con los resultados uno por uno recorriendo la tabla:
		;MsgBox(0, $sResult, execute($sResult))
		; ahora sí vamos a lo serio. Aquí escribiremos una línea en el documento que creamos desde el inicio con la información de la tabla.
		; Esto escribirá el contenido de la variable $sResult (9*9 por ejemplo) igual a 81. El resultado (81) lo obtenemos llamando a la función execute, concatenando, ovbiamente.
		FileWriteLine($hFile, $sResult & " = " & Execute($sResult))
		; se acava el segundo bucle:
	Next
	; terminamos el primer bucle también:
Next
; finalmente, cerramos el archivo generado de tablas, debido a que ya no lo necesitaremos más:
FileClose($hFile)
; mostrar mensaje:
MsgBox(0, "éxito", "Se hizo una tabla de 12x12. ¡Compruébala y repásala!")
; #FUNCTION# ====================================================================================================================
; Name ..........: _table
; Description ...: Crea una tabla de un número por otro número (por defecto 12) y esa tabla estará en una matriz 2d. En la primera columna el multiplicando, y en la segunda el multiplicador.
; Syntax ........: _table($iTable[, $iLimit = 12])
; Parameters ....: $iTable              - Crear la tabla del ¿Número?.
;                  $iLimit              - [opcional] Los elementos de la tabla. Por defecto es 12, por lo que creará una tabla de hasta número ($iTable) por 12.
; Return values .: La tabla de multiplicación generada
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _table($iTable, $iLimit = 12)
	; establecemos los limitadores de la matriz y a su vez creamos la tabla:
	Dim $aArray[$iLimit][2]
	; ejecutaremos un bucle de 0 hasta el $iLimit:
	For $I = 0 To $iLimit - 1
		; establecemos el valor de la tabla creada en la fila $I columna 0 con el valor de $iTable (el multiplicando):
		$aArray[$I][0] = $iTable
		; ahora, establecemos el valor de la tabla creada en la fila $I columna 1 con el valor de $i (el multiplicador) más uno, ya que el $I comienza desde 0, pero el formato de la tabla comienza en 1, ni modo que vamos a hacer algo como 0 por 5:
		$aArray[$I][1] = $I + 1
		; terminamos el bucle:
	Next
	;_arraydisplay($aArray)
	; finalmente, retornamos la nueva matriz, es decir, la tabla generada:
	Return $aArray
EndFunc   ;==>_table
; #FUNCTION# ====================================================================================================================
; Name ..........: _execute_Table
; Description ...: esta función ejecutará (o resolverá) Una tabla ya creada, por lo que necesitaremos la matriz compatible con la tabla que creamos con _table. Por lo tanto, almacenará los resultados en una matriz 1d.
; Syntax ........: _execute_Table($aTable)
; Parameters ....: $aTable              - La variable (matriz) que contenga la tabla hecha.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _execute_Table($aTable)
	; aquí tendremos la siguiente condición: si la tabla que le hemos dado no tiene dos columnas, o, si no es una tabla 2d, esta función retornará @error.
	If Not UBound($aTable, $UBOUND_COLUMNS) = 2 Or Not UBound($aTable, $UBOUND_DIMENSIONS) = 2 Then Return SetError(1, 0)
	; declaramos la matriz de resultados:
	Local $aResults
	; hacemos un bucle de 0 hasta donde termine la tabla (en filas):
	For $I = 0 To UBound($aTable, $UBOUND_ROWS) - 1
		; establecemos el resultado de la multiplicación al elemento de la matriz llamando a la función execute:
		; recordemos que fila $I columna 0 son multiplicadores, y fila $I columna 1 son multiplicandos.
		$aResult[$I] = Execute($aTable[$I][0] & "*" & $aTable[$I][1])
		; terminamos el bucle:
	Next
	; y finalmente, retornamos la matriz de resultados:
	Return $aResult
EndFunc   ;==>_execute_Table
