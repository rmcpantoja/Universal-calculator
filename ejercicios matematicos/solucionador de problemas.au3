; solucionador de problemas
#include "include\generador_operaciones.au3"
Fun _GenerarProblema()
local $aNombres, $aAcciones1, $aAcciones2, $aSujeto1, $aSujeto2, $aCantidad1, $aCantidad2
$aNombres = ["Pepito", "Juanita", "Juanito", "Marcela", "Marcelo", "Daniel", "Daniela", "Mario", "María", "Emilia", "Emilio", "Denis", "Dennisse", "Samanta", "Amanda", "pablo", "Paola", "Mónica", "Rogelio", "Alfonso", "Marina", "Cristian", "Cristina", "Martín", ""Martina", "Gabriela", "Gabriel", "Carlos", "Carla", "Gonzalo", "Johana", "Johan", "Ximena", "Laura", "Diego", "Esteban", "Sergio", "Raúl", "Juan", "Ana", "Francisca", "Francisco", "Lola", "Miguel", "Rafaela", "Rafael", "David", "Alberto", "Luis", "Germán", "Brayan", "Mateo", "Milagros", "Mercedes", "Daniel", "Sevastián", "Víctor", "Hugo", "Arturo", "Crístofer", "Angel", "Lucía", "Luciana", "Lucio", "Helena", "Samuel", "Teresa", "Tatiana", "Angélica", "Antonio"]
$aAcciones1 = ["Se fue a", "Fue a", "visitó a", "está visitando a", "visitó a", "se encontró con", "partió a", "tomó el camino a", "fue con", "está yendo con", "fue junto a", "está junto a", "está con", "se encuentra junto con", "se encuentra", "está ubicado en", "está", "se siente", "está viajando a", "está yendo a", "está conduciendo hacia", "está comprando", "está vendiendo"]
$aAcciones2 = ["la tienda", "pasear", "su familia", "su amigo", "su primo", "el parque", "su casa", "la calle", "la fiesta", "el restaurante", "la escuela", "el centro", "el shoping", "otro país", "la ciudad que anhelaba ir", "a una parte muy impresionante de la ciudad"]
$aSugeto1 = ["Compra", "Vende", "Regala", "Presta", "Tiene", "Ganó", "Perdió", "Tuvo", "Tenía", "Trajo", "ENtregó", "Regaló", "Regalaron", "Prestaron", "Prestar"]
$aSugeto2 = ["Pera", "Manzana", "Fruta", "chocolate", "dólar", "centavo", "canasta", "auto", "cocina", "chaqueta", "teléfono", "altavoz", "dulce", "rompecaveza", "pelota"]
EndFunc