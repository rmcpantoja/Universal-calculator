#include-once
; setting variables:
; calculator globals:
Global $aInteraccion[]
Global $aNumbers[]
Global $aNums[], $aFormulas[], $aProceso[]
global $nResultado
Global $sInterOperacion = "", $sProceso = "", $sTipoElevacion = "", $sTipoRaiz = ""
; program globals:
Global $sProgramVer = "0.1"
; UI globals:
Global $bHideKeyboard = False
Global $hGUI, $idInteraccion, $idClearScreen, $idFORMULAS, $idOpciones, $idRazon, $idEtiquetaInput, $idEtiquetarLista, $idAbout, $idIgual, $idMSG, $idOcultarKey
; related to config paths:
global $sConfigFolder = @ScriptDir &"\config"
global $sConfigPath = $sConfigFolder &"\config.st"
; related to configs:
global $sEnhableProgresses, $sEnhancedAccess, $sLang