; Program created by Mateo Cedillo, GUI creation by Valeria Parra feat: AutoBuilder 0.9f Prototype
; Programa creado por Mateo Cedillo, creación de GUI por Valeria Parra feat: AutoBuilder 0.9f Prototype
; set directives for compilation:
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=N
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=This is a mini calculator, but big at same time, because you can do advanced formulas and operations too!
#AutoIt3Wrapper_Res_Description=Universal calculator
#AutoIt3Wrapper_Res_Fileversion=0.1.0.20
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
#include "include\calculator\gui.au3"
#include "include\calculator\keyboard.au3"
#include "include\calculator\params.au3"
#include "include\reader.au3"
#include "include\calculator\reasons.au3"
#include <StaticConstants.au3>
#include <StringConstants.au3>
#include "include\calculator\UI.au3"
#include <WindowsConstants.au3>
;Universal calculator (in development):

; We call the main function of the program:
Main()