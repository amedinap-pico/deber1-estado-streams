# Respuestas de la Parte B

## 6. ¿Por qué la pantalla siguió mostrando "Wi‑Fi" si el Wi‑Fi ya estaba apagado?
La pantalla tenía una instantánea del estado de la conexión, no un flujo continuo que escuchara cambios del sistema. El valor era correcto para el momento de la consulta, pero ya no correspondía a la realidad actual.

## 7. ¿Qué pasaría si borras el cancel() del close() del Cubit y el usuario entra y sale cincuenta veces?
Quedarían cincuenta suscripciones activas al stream de conexión. Eso generaría fugas de memoria, más emisiones repetidas y consumo innecesario de batería y CPU.

## 8. ¿Por qué decimos que un Future es una foto y un Stream una película?
Un `Future` responde una vez: “¿cómo está la conexión ahora?”; un `Stream` avisa cada vez que cambia. La conexión es un dato dinámico, por eso el `Stream` refleja la evolución real, mientras que el `Future` solo da un instante concreto.

Dos datos con `Future`: consultar si hay conexión ahora y leer la hora exacta de una consulta.
Dos datos con `Stream`: estado de red en tiempo real y cambios de localización o batería.
