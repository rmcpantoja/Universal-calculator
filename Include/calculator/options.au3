; options:
#include <comboConstants.au3>
#include "configs.au3"
#include "globals.au3"
#include <GuiConstantsEx.au3>
#include "language_manager.au3"
#include "..\translator.au3"
;_options()
Func _Options($sConfigFolder, $sConfigPath)
local $hOptionsGui, $idLanguage, $idAutocompleteFormula, $idApply, $idClose
local $sCompleteOption, $sCompleteRead
_config_start($sConfigFolder, $sConfigPath)
$hOptionsGui = GuiCreate("Options")
$idLanguage = GuiCtrlCreateButton("Change language, currently" &" " & $sLang, 10, 10, 120, 20)
GuiCtrlCreateLabel("Choose autocompletion mode", 70, 10, 120, 20)
$idAutocompleteFormula = GuiCtrlCreateCombo("", 70, 70, 120, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
if $sFormulaAutocompletion = "1" then
$sCompleteRead = "GUI mode"
Else
$sCompleteRead = "Autocomplete mode"
EndIf
GuiCtrlSetData($idAutocompleteFormula, "Autocomplete mode|GUI mode", $sCompleteRead)
$idApply = GuiCtrlCreateButton("&Apply", 150, 10, 200, 20)
GuiSetState(@SW_SHOW)
while 1
switch GuiGetMSG()
case $idLanguage
Selector()
case $idAutocompleteFormula
$sCompleteOption = GuiCtrlRead($idAutocompleteFormula)
if $sCompleteOption = "GUI mode" then
IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "1")
Else
IniWrite($sConfigPath, "Calculator", "formula autocompletion mode", "2")
EndIf
case -3 or $idApply
GuiDelete($hOptionsGui)
ExitLoop
EndSwitch
WEnd
EndFunc