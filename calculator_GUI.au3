#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=../compiled/UniversalCalc.exe
;#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=An easy, simple and interactive calculator where you can interact using many formulas and mathematical operations
#AutoIt3Wrapper_Res_Description=Universal calculator
#AutoIt3Wrapper_Res_Fileversion=0.1.0.62
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Universal calculator
#AutoIt3Wrapper_Res_ProductVersion=0.1.0.0
#AutoIt3Wrapper_Res_CompanyName=MT Programs
#AutoIt3Wrapper_Res_LegalCopyright=© 2018-2024 MT Programs, All rights reserved
#AutoIt3Wrapper_Run_Before="build.bat"
;#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; Program created by Mateo Cedillo, GUI creation by Valeria Parra and Xx_Nessu_xX feat: AutoBuilder 0.9f Prototype and GuiBuilderPlus v1.0.0-beta - 2022-07-12
; set directives for compilation:
;#AutoIt3Wrapper_Res_Language=12298
;#AutoIt3Wrapper_Run_Tidy=y

; include dependencies:
#include "include\calculator\configs.au3"
#include "include\calculator\globals.au3"
#include "include\calculator\UI.au3"
;program loading:
SoundPlay(@ScriptDir & "\sounds\open.wav", 0)
; check for configs:
_config_start($sConfigFolder, $sConfigPath)
If $sEnhancedAccessibility = "yes" Then _accessibility_config_start($sConfigFolder, $sConfigPath)
; Configure global accessibility key commands:
If $sEnhancedAccessibility = "yes" Then
	For $iScriptKey = 0 To UBound($aScriptkeys) - 1
		HotKeySet($aScriptkeys[$iScriptKey][0], $aScriptkeys[$iScriptKey][1])
	Next
EndIf
; We call the main function of the program:
Main()
