#include "globals.au3"
#include <GuiConstantsEx.au3>
#include "params.au3"
#include <StringConstants.au3>
#include "..\translator.au3"
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: CreateParams
; Description ...: This function is the graphical interface support for working with the parameters of a formula.
; Syntax ........: CreateParams(Byref $idListView)
; Parameters ....: $idListView          - the ID of the listview control that contains the formulas. name|description|command.
; Return values .: The final command result of this formula with all the parameters already set by user.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func CreateParams(ByRef $idListView)
	Local $sExtract, $sCommandToApply, $sCommandToSearch, $aArray[], $iNumParam, $idInputs[], $iLabels[], $idApply, $nFormula = ""
	$sExtract = GUICtrlRead(GUICtrlRead($idListView))
	If Not $sExtract = 0 Then
		$aArray = StringSplit($sExtract, "|")
		If Not $aArray[0] = 3 Then Return SetError(1, 0, "")
	Else
		Return SetError(2, 0, "")
	EndIf
	$sCommandToApply = $aArray[1]
	$sCommandToSearch = $aArray[3]
	$iNumParam = _SearchParam($sCommandToSearch)
	If @error Then
		Switch @error
			Case 1
				Return SetError(3, 0, "")
			Case 2
				Return SetError(4, 0, "")
		EndSwitch
	Else
		$hCommandGUI = GUICreate(translate($sLang, "Applying formula") & ": " & $aArray[1])
		$label1 = GUICtrlCreateLabel( _
				translate($sLang, "Enter the needed parameters of this formula, then press apply to get the final result. If you need help with parameters of each formula, please read the guide"), _
				0, 10, 200, 20 _
				)
		If $sCommandToSearch = "av" Then
			$iLabels[0] = GUICtrlCreateLabel( _
					translate($sLang, "Please separate your values with space"), _
					80, 10, 100, 20 _
					)
			$idInputs[0] = GUICtrlCreateInput( _
					"", 80, 80, 100, 20 _
					)
		Else
			For $I = 0 To $iNumParam - 1
				$iLabels[$I] = GUICtrlCreateLabel( _
						translate($sLang, "parameter") & " " & $I + 1, _
						80 * $I, 10, 100, 20 _
						)
				$idInputs[$I] = GUICtrlCreateInput( _
						"", 80, 80 * $I, 100, 20 _
						)
			Next
		EndIf
		$idApply = GUICtrlCreateButton( _
				translate($sLang, "&Apply"), _
				300, 300, 100, 20 _
				)
		$idClosebtn = GUICtrlCreateButton( _
				translate($sLang, "&Close"), _
				300, 380, 100, 20 _
				)
		Local $aAccel[][2] = [["{enter}", $idApply]]
		GUISetAccelerators($aAccel)
		GUISetState(@SW_SHOW)
		While 1
			Switch GUIGetMsg()
				Case $GUI_EVENT_CLOSE, $idClosebtn
					GUIDelete($hCommandGUI)
					Return SetError(5, 0, "")
					ExitLoop
				Case $idApply
					For $I = 0 To UBound($idInputs) - 1
						If GUICtrlRead($idInputs[$I]) = "" Then
							GUIDelete($hCommandGUI)
							Return SetError(6, 0, "")
							ExitLoop
						Else
							$nFormula &= GUICtrlRead($idInputs[$I]) & " "
						EndIf
					Next
					GUIDelete($hCommandGUI)
					Return $sCommandToSearch & ":" & StringStripWS($nFormula, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
					ExitLoop
			EndSwitch
		WEnd
	EndIf
EndFunc   ;==>CreateParams
; #FUNCTION# ====================================================================================================================
; Name ..........: Autocomplete_and_put
; Description ...: This function is about auto-complete the name of the formula with which you are going to work.
; Syntax ........: Autocomplete_and_put(Byref $idListView)
; Parameters ....: $idListView          - The control ID of the listview that contains the formula table. Name|Description|Command.
; Return values .: A string containing the command to complete.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func Autocomplete_and_put(ByRef $idListView)
	Local $aArray
	Local $sCommand, $sExtract
	$sExtract = GUICtrlRead(GUICtrlRead($idListView))
	If Not $sExtract = 0 Then
		$aArray = StringSplit($sExtract, "|")
		If Not $aArray[0] = 3 Then Return SetError(1, 0, "")
	Else
		Return SetError(2, 0, "")
	EndIf
	$sCommand = $aArray[3]
	Return $sCommand & ":"
EndFunc   ;==>Autocomplete_and_put
