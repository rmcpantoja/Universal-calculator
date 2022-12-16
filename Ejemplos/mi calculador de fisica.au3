;Mateo C:
$nVelocidadInicial = inputbox("Calculador de Mateo C: Velocidad inicial", "Escribe la velocidad inicial en metros / segundos")
$nANgulo = inputbox("ángulo", "Escribe aquí")
$nGravedad = inputbox("Gravedad", "La gravedad, mayormente es 9.80", 19.6)
MsgBox(0, "Resultado", ObtenerAlturaMaxima($nVelocidadInicial, $nANgulo, $nGravedad))
Func ObtenerAlturaMaxima($nVelocidadInicial, $nANgulo, $nGravedad)
$nProcess = ($nVelocidadInicial * $nVelocidadInicial)
$nSin = Sin($nProcess)
$nProcess2 = $nSin * $nSin * $nAngulo / 2 * $nGravedad
return $nProcess2
EndFunc
func ObtenerAngulo($nGravedad, $nTiempo, $nVelocidadInicial)
$nResult = $nGravedad * $nTiempo / $nVelocidadInicial
return round($nResult)
EndFunc