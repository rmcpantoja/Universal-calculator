; Program created by Mateo Cedillo, GUI creation by Valeria Parra feat: AutoBuilder 0.9f Prototype
; Programa creado por Mateo Cedillo, creación de GUI por Valeria Parra feat: AutoBuilder 0.9f Prototype
; set directives for compilation:
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=N
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=This is a mini calculator, but big at same time, because you can do advanced formulas and operations too!
#AutoIt3Wrapper_Res_Description=Universal calculator
#AutoIt3Wrapper_Res_Fileversion=0.1.0.18
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Universal calculator
#AutoIt3Wrapper_Res_ProductVersion=0.1.0.0
#AutoIt3Wrapper_Res_CompanyName=MT Programs
#AutoIt3Wrapper_Res_LegalCopyright=© 2018-2022 MT Programs, All rights reserved
#AutoIt3Wrapper_Res_Language=12298
;#AutoIt3Wrapper_Run_Tidy=y
;#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; include dependencies:
#include <array.au3>
#include "include\calculator\calc.au3"
#include <Constants.au3>
#include <EditConstants.au3>
#include "include\mymath\elevar.au3"
#include "include\mymath\fisica.au3"
#include "include\calculator\gui.au3"
#include "include\calculator\keyboard.au3"
#include <Math.au3>
;#include "include\advmathudf-au3\Math.au3"
#include "include\mymath\Progresiones.au3"
#include "include\mymath\raiz.au3"
#include "include\calculator\params.au3"
#include "include\reader.au3"
#include "include\calculator\reasons.au3"
#include "include\advmathudf-au3\Math\Roots.au3"
#include <StaticConstants.au3>
#include <StringConstants.au3>
#include "include\calculator\UI.au3"
#include <WindowsConstants.au3>
;Universal calculator (in development):
; setting variables:
Global $sProgramVer = "0.1"
Global $aInteraccion[]
Global $aNumbers[]
Global $sInterOperacion = "", $nResultado = "", $sTipoElevacion = "", $sTipoRaiz = ""
Global $aNums[], $aFormulas[]
Global $bHideKeyboard = False
; help table:
Global $aInfoFormulas[] = ["Radianes a grados|Convierte un número determinado de radianes a grados", "Número máximo|Entre dos números, se verifica cuál es el máximo", "Número mínimo|Entre dos números, se verifica cuál es el menor", "Grados a radianes|Convierte un número determinado de grados a radianes", "Aceleración|Optiene la aceleración de una velocidad y un tiempo", "arcocoseno|Calcula el arcocoseno de una expresión", "Arcoseno|Calcula el arcoseno de una expresión", "Arcotangente|Calcula el arcotangente de una expresión", "Coseno|Calcula el coseno de una expresión", "distancia|Optiene la distancia de una velocidad o tiempo determinados", "Logaritmo|Calcula el logaritmo de una expresión", "redondear|Redondea un número decimal al más cercano posible", "Seno|Calcula el seno de una expresión", "tangente|Calcula la tangente de una expresión", "Progresión aritmética: a1|Obtiene el primer término", "Progresión geométrica: a1|Obtiene el primer término de una progresión geométrica", "Progresión aritmética: d|Obtiene la diferencia", "Progresión geométrica: R|Obtiene la razón", "Progresión aritmética: n|Obtiene el número de término", "Progresión geométrica: N|Obtiene el número de término", "Progresión aritmética: AN|Obtiene el término enésimo", "Progresión geométrica: an|Obtiene el término enésimo", "Progresión aritmética: SN1|Este es el primer método que suma los términos", "Progresión geométrica: sn1|Primer método que suma los términos", "Elevar|Potencia, ej: 3 elevado a la 8", "Raíz|Aplica una raíz cualquiera de un número, ej: Raíz cuarta de 1024", "Raíz cuadrada|Aplica la raíz cuadrada de un número determinado", "raíz cúbica|Aplica la raíz cúbica de un número determinado", "Tiempo|Optiene el tiempo de una velocidad y distancia definidos", "Velocidad|Optiene la velocidad de una distancia y un tiempo determinados"]
Global $aFlista = _SearchParam(Null, Default, True)
_ArrayColDelete($aFlista, 1, True)
Global $hGUI, $idInteraccion, $idClearScreen, $idFORMULAS, $idOpciones, $idRazon, $idEtiquetaInput, $idEtiquetarLista, $idAbout, $idIgual, $idMSG
; We call the main function of the program:
Main()