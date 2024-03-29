; Script generated by AutoBuilder 0.9f Prototype

#region ---Head--
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <WindowsConstants.au3>

#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <ListBoxConstants.au3>
#include <ButtonConstants.au3>

Global $hGUI,$calculadora,$CERO,$PUNTO,$IGUAL,$NUEVE,$OCHO,$CUATRO,$UNO,$CINCO,$SEIS,$SIETE,$TRES,$DOS,$PORCENTAJE,$MENOS,$POR,$DIVISOR,$MAS,$ABRIRPARENTECIS,$CERRARPARENTECIS,$BORRAR,$FORMULAS,$opciones,$razon,$idEtiquetaInput,$idEtiquetarLista,$idAbout
create_form()
#endregion ---Head---

#region --- Form ---

func create_form()
global $aNums[], $aFormulas[]
global $aInfoFormulas[] = ["Radianes a grados|Convierte un n�mero determinado de radianes a grados."]
$hGUI=GuiCreate("Calculator", 384, 311, -1, -1, $WS_OVERLAPPED + $WS_CAPTION + $WS_SYSMENU)
$idEtiquetarInteraccion = GuiCtrlCreateLabel("Escribir operaci�n", 10, 10, 160, 90,-1)
$idInteraccion = GuiCtrlCreateInput("", 170, 0, 220, 110,-1)
$aNums[0] = GuiCtrlCreateButton("0", 140, 280, 30, 30,-1)
$aNums[1] = GuiCtrlCreateButton("1", 140, 240, 30, 30,-1)
$aNums[2] = GuiCtrlCreateButton("2", 180, 240, 30, 30,-1)
$aNums[3] = GuiCtrlCreateButton("3", 220, 240, 30, 30,-1)
$aNums[4] = GuiCtrlCreateButton("-", 250, 240, 30, 30,-1)
$aNums[5] = GuiCtrlCreateButton("4", 130, 200, 30, 30,-1)
$aNums[6] = GuiCtrlCreateButton("5", 170, 200, 30, 30,-1)
$aNums[7] = GuiCtrlCreateButton("6", 210, 200, 30, 30,-1)
$aNums[8] = GuiCtrlCreateButton("*", 250, 200, 30, 30,-1)
$aNums[9] = GuiCtrlCreateButton("7", 130, 160, 30, 30,-1)
$aNums[10] = GuiCtrlCreateButton("8", 170, 160, 30, 30,-1)
$aNums[11] = GuiCtrlCreateButton("9", 210, 160, 30, 30,-1)
$aNums[12] = GuiCtrlCreateButton("/", 250, 160, 30, 30,-1)
$aNums[13] = GuiCtrlCreateButton(".", 170, 280, 30, 30,bitor($SS_CENTER,0,0))
$idIGUAL = GuiCtrlCreateButton("=", 220, 280, 30, 30,bitor($SS_CENTER,0,0))
$aNums[14] = GuiCtrlCreateButton("+", 260, 280, 30, 30,-1)
$aNums[15] = GuiCtrlCreateButton("%", 130, 130, 30, 30,-1)
$aNums[16] = GuiCtrlCreateButton("(", 160, 130, 30, 30,-1)
$aNums[17] = GuiCtrlCreateButton(")", 200, 130, 30, 30,-1)
$idClearScreen = GuiCtrlCreateButton("C", 240, 130, 30, 30,-1)
$idEtiquetarLista = GuiCtrlCreateLabel("Comandos disponibles:", 280, 170, 80, 30,-1)
$FORMULAS = GuiCtrlCreateListView("Nombre|Descripci�n|F�rmula", 10, 110, 90, 149,-1)
$idOpciones = GuiCtrlCreateButton("opciones", 40, 260, 60, 70,-1)
$idMostrarRazon = GuiCtrlCreateButton("raz�n", 280, 110, 40, 50,-1)
$idAbout = GuiCtrlCreateButton("acerca de", 280, 210, 80, 50,-1)
For $I = 0 to uBound($aInfoFormulas) -1
GUICtrlCreateListViewItem($aInfoFormulas[$I], $Formulas)
Next
GuiSetState()
endfunc
#EndRegion --- Form ---

#region --- Loop ---
While 1
$idMsg = GuiGetMsg()
switch $idMsg
case $GUI_EVENT_CLOSE
ExitLoop
case $aNums[0] to $aNums[17]
For $I = 0 to 17
if $idMsg = $aNums[$I] then
$sText = ControlGetText($hGUI, "", "Edit1")
ControlSetText($hGUI, "", "Edit1", $sText &ControlGetText($hGUI, "", $aNums[$I]))
EndIf
Next
EndSwitch
WEnd
#Endregion --- Loop ---

#Region --- Additional Functions ---
#Endregion --- Additional Functions ---

Exit

