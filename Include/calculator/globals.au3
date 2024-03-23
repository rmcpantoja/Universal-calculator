#include "..\reader.au3"
#include-once
; setting variables:
; calculator globals:
Global $aSplitCMD[]
Global $aNumbers[]
Global $aNums[], $aFormulas[], $aProcess[], $aPercentArray[], $aStoreOperators[]
global $bSpeak_numbers = False
global $nResult
Global $sOperation = "", $sProcess = "", $sRaiseType = "", $sRootType = ""
; program globals:
global $oCloseSND, $oOpenSND
Global $sProgramVer = "v0.1a6"
; UI globals:
Global $bHideKeyboard = False
Global $hGUI, $idInter, $idClearScreen, $idFORMULAS, $idOptions, $idGetReason, $idInterLabel, $idCommandsLb, $idAbout, $idEqual, $idMSG, $idHideKey
; related to config paths:
global $sConfigFolder = @ScriptDir &"\config"
global $sConfigPath = $sConfigFolder &"\config.st"
; related to configs:
global $sEnableProgresses, $sEnhancedAccessibility, $sFormulaAutocompletion, $sShowTips, $sForceEnter, $sCommit, $sCommitGot = "", $sCheckForUpdate, $sUpdateSource, $sLang = "en"
; related to accessibility configs:
global $aScriptkeys[][2] = [["+{f2}", "_switch_read_keys"], _
	["^+o", "_scriftkey_options"]]
global $sSpeak_result, $sReadPosition
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
	SoundPlay(@ScriptDir & "\sounds/close.wav", 0)
	_nvdaControllerClient_free()
	Sleep(1000)
	Exit
EndFunc   ;==>exitpersonaliced
