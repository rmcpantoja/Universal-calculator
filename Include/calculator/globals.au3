#include-once
; setting variables:
; calculator globals:
Global $aInteraccion[]
Global $aNumbers[]
Global $aNums[], $aFormulas[]
global $nResultado
Global $sInterOperacion = "", $sTipoElevacion = "", $sTipoRaiz = ""
; program globals:
Global $sProgramVer = "0.1"
; UI globals:
Global $bHideKeyboard = False
Global $hGUI, $idInteraccion, $idClearScreen, $idFORMULAS, $idOpciones, $idRazon, $idEtiquetaInput, $idEtiquetarLista, $idAbout, $idIgual, $idMSG, $idOcultarKey
; related to config:
global $sConfigPath = @ScriptDir &"\config\config.st"