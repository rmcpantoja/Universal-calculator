#include "..\audio.au3"
#include "..\reader.au3"
#include-once
; setting variables:
; calculator globals:
Global $aSplitCMD[]
Global $aNumbers[]
Global $aNums[], $aFormulas[], $aProcess[]
global $nResult
Global $sOperation = "", $sProcess = "", $sRaiseType = "", $sRootType = ""
; program globals:
global $oCloseSND, $oOpenSND
Global $sProgramVer = "0.1"
; UI globals:
Global $bHideKeyboard = False
Global $hGUI, $idInter, $idClearScreen, $idFORMULAS, $idOptions, $idGetReason, $idInterLabel, $idCommandsLb, $idAbout, $idEqual, $idMSG, $idHideKey
; related to config paths:
global $sConfigFolder = @ScriptDir &"\config"
global $sConfigPath = $sConfigFolder &"\config.st"
; related to configs:
global $sEnableProgresses, $sEnhancedAccess, $sFormulaAutocompletion, $sLang
; global functions:
; #FUNCTION# ====================================================================================================================
; Name ..........: exitpersonaliced
; Description ...: Custom exit function
; Syntax ........: exitpersonaliced()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func exitpersonaliced()
	$oCloseSND = $device.opensound(@ScriptDir & "\sounds/close.ogg", True)
	_nvdaControllerClient_free()
	$oCloseSND.play
	Sleep(1000)
	Exit
EndFunc   ;==>exitpersonaliced
