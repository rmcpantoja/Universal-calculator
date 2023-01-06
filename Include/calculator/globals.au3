#include-once
; setting variables:
Global $sProgramVer = "0.1"
Global $aInteraccion[]
Global $aNumbers[]
Global $sInterOperacion = "", $nResultado = "", $sTipoElevacion = "", $sTipoRaiz = ""
Global $aNums[], $aFormulas[]
Global $bHideKeyboard = False
Global $hGUI, $idInteraccion, $idClearScreen, $idFORMULAS, $idOpciones, $idRazon, $idEtiquetaInput, $idEtiquetarLista, $idAbout, $idIgual, $idMSG, $idOcultarKey
global $sConfigPath = @ScriptDir &"\config\config.st"