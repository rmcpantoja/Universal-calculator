; Program created by Mateo Cedillo, GUI creation by Valeria Parra feat: AutoBuilder 0.9f Prototype and GuiBuilderPlus v1.0.0-beta - 2022-07-12
; set directives for compilation:
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=N
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=This is a mini calculator, but big at same time, because you can do advanced formulas and operations too!
#AutoIt3Wrapper_Res_Description=Universal calculator
#AutoIt3Wrapper_Res_Fileversion=0.1.0.47
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Universal calculator
#AutoIt3Wrapper_Res_ProductVersion=0.1.0.0
#AutoIt3Wrapper_Res_CompanyName=MT Programs
#AutoIt3Wrapper_Res_LegalCopyright=© 2018-2023 MT Programs, All rights reserved
#AutoIt3Wrapper_Res_Language=12298
#AutoIt3Wrapper_OutFile=../compiled/UniversalCalc.exe
;#AutoIt3Wrapper_Run_Tidy=y
;#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#AutoIt3Wrapper_Run_Before="build.bat"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; include dependencies:
#include "include\calculator\configs.au3"
#include <Constants.au3>
#include "include\calculator\globals.au3"
#include "include\calculator\UI.au3"
;Universal calculator (in development):
; check for configs:
_config_start($sConfigFolder, $sConfigPath)
SoundPlay(@ScriptDir & "\sounds\open.ogg", 0)
; We call the main function of the program:
Main()