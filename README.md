# CitiesChallenge
Bienvenidos! 
Les presento el proyecto.

Dejo un poco de contexto:

Lo que si:
- Buscamos dar solución al problema propuesto con una arquitectura MVVM, intentando tender a lo más "clean" posible.
- Se utilizaron extensiones y abstracciones de vistas a conveniencia.
- Se utilizó la navegación de UIKit por una cuestion de fiabilidad y flexibilidad para la solucion propuesta.
- El framework SwifUI se encuentra en el 95% del desarrollo de la solución
- Para facilitar la estrategia de tests unitarios, se utilizó inyección de dependencias y POOP, por cuestiones de tiempo obtuve el 60% de coverage, pero se puede apreciar facilmente que podría subir ese porcentaje porque el flujo es totalmente testeable.


Lo que no:
- No llegué a armar una pantalla en donde se muestre mas información del país que se tapea, de todas maneras dejé en el componente un botón que recibe la closure que navegaría al lugar en cuestión
- Me hubiese gustado manejar estados de loading, sobre todo para el principio de la carga.
- Algun detalle de UI que se me pasó, paddings o interacciones. Me hubiese gustado trabajar mas en las animaciones.

Quedo a la espera de feedback!

Saludos!.
