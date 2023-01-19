#include "..\translator.au3"
#include-once
; help table:
global $aInfoFormulas = ["Radianes a grados|Convierte un número determinado de radianes a grados", "Número máximo|Entre dos números, se verifica cuál es el máximo", "Número mínimo|Entre dos números, se verifica cuál es el menor", "Grados a radianes|Convierte un número determinado de grados a radianes", "Aceleración|Optiene la aceleración de una velocidad y un tiempo", "arcocoseno|Calcula el arcocoseno de una expresión", "Arcoseno|Calcula el arcoseno de una expresión", "Arcotangente|Calcula el arcotangente de una expresión", "Cálculo del perímetro|Calcula el perímetro basándose en la longitud y la anchura ya sea de un rectángulo o la figura que se desee", "Coseno|Calcula el coseno de una expresión", "distancia|Optiene la distancia de una velocidad o tiempo determinados", "Logaritmo|Calcula el logaritmo de una expresión", "redondear|Redondea un número decimal al más cercano posible", "Seno|Calcula el seno de una expresión", "tangente|Calcula la tangente de una expresión", "Progresión aritmética: a1|Obtiene el primer término", "Progresión geométrica: a1|Obtiene el primer término de una progresión geométrica", "Progresión aritmética: d|Obtiene la diferencia", "Progresión geométrica: R|Obtiene la razón", "Progresión aritmética: n|Obtiene el número de término", "Progresión geométrica: N|Obtiene el número de término", "Progresión aritmética: AN|Obtiene el término enésimo", "Progresión geométrica: an|Obtiene el término enésimo", "Progresión aritmética: SN1|Este es el primer método que suma los términos", "Progresión geométrica: sn1|Primer método que suma los términos", "Elevar|Potencia, ej: 3 elevado a la 8", "Raíz|Aplica una raíz cualquiera de un número, ej: Raíz cuarta de 1024", "Raíz cuadrada|Aplica la raíz cuadrada de un número determinado", "raíz cúbica|Aplica la raíz cúbica de un número determinado", "Tiempo|Optiene el tiempo de una velocidad y distancia definidos", "Velocidad|Optiene la velocidad de una distancia y un tiempo determinados"]
; form table:
global $aCommandTable = [["deg", 1], ["max", 2], ["min", 2], ["rad", 2], ["acc", 2], ["acos", 1], ["asin", 1], ["atan", 1], ["pc", 2], ["cos", 1], ["dox", 2], ["log", 1], ["ro", 1], ["sin", 1], ["tan", 1], ["ap-a1", 3], ["gp-a1", 3], ["ap-d", 3], ["gp-r", 3], ["ap-n", 3], ["gp-n", 3], ["ap-an", 3], ["gp-an", 3], ["ap-sn1", 3], ["gp-sn1", 3], ["raise", 2], ["root", 2], ["sr", 1], ["cr", 1], ["time", 2], ["vel", 2]]
; #FUNCTION# ====================================================================================================================
; Name ..........: _get_formule_table
; Description ...: Gets the default formula table, useful for working with parameters.
; Syntax ........: _get_formule_table()
; Parameters ....: None
; Return values .: Default formula table
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _get_formule_table()
	Return $aCommandTable
EndFunc   ;==>_get_formule_table
