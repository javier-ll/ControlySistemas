# ControlySistemas
El presente proyecto estudia el desempeño de una suspensión semiactiva en un automóvil, comparando diferentes estrategias de control: Skyhook, Groundhook e Híbrido, frente a una suspensión
pasiva.
Se modeló un cuarto de vehículo de un Audi R8 circulando a 60 km/h sobre un reductor de velocidad, evaluando la controlabilidad y observabilidad del sistema. Para lograr una implementación realista, se consideraron las limitaciones del actuador mediante un bloque saturador y se modelaron los sensores con funciones cuantizadoras en C, cuyo ruido de cuantización se puede representar como ruido blanco uniforme.
Dado que no todas las variables de estado son medibles, se diseñó un filtro de Kalman para estimarlas a partir de las señales disponibles. Posteriormente, se evaluó el desempeño del control Híbrido, destacando su balance entre confort y estabilidad, y se comparó con la suspensión pasiva.
Los resultados muestran que el control Híbrido mejora significativamente el compromiso entre comodidad y adherencia al suelo, mientras que el filtro de Kalman permite una estimación precisa
de las variables de estado incluso en presencia de ruido.
