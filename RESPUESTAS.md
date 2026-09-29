# Respuestas: Deber 1

## Parte A

### 1. ¿Que paso al salir con el boton atras del sistema?

El incremento se guardo en SharedPreferences, pero el visor con `setState` conservo en memoria el valor anterior. Al volver con el boton atras del sistema no se ejecuto el codigo de `Navigator.pop` que devuelve el valor; por eso quedo desactualizado el estado local del visor, no el dato en disco. Para sincronizar las pantallas tuvieron que coordinarse la pantalla visor, la pantalla control y la navegacion con el valor de retorno.

### 2. ¿Por que Riverpod no pierde el cambio? ¿Donde vive el contador?

El contador vive en el estado del provider, fuera del estado local de cada pantalla. Ambas pantallas leen y modifican la misma instancia compartida; al regresar o usar el boton atras, el provider sigue vivo y el visor vuelve a observar el valor actualizado.

### 3. ¿Que aporta BlocObserver?

Permite inspeccionar cada transicion con el estado anterior y el nuevo, por ejemplo `ContadorCubit: 3 -> 4`. Esto resulta util al depurar flujos de usuario, diagnosticar actualizaciones duplicadas o reconstruir como se llego a un estado incorrecto en produccion.

### 4. ¿Que demuestra la comparacion entre ramas?

Comandos y resultados obtenidos:

```text
git diff version/setstate version/riverpod -- lib/domain lib/data
(sin salida)

git diff version/setstate version/bloc -- lib/domain lib/data
(sin salida)

git diff --stat version/setstate version/bloc -- lib/presentation
 lib/presentation/estado/contador_cubit.dart      | 29 +++++++
 lib/presentation/pantallas/pantalla_control.dart | 96 ++++++++----------------
 lib/presentation/pantallas/pantalla_visor.dart   | 96 ++++++++----------------
 3 files changed, 93 insertions(+), 128 deletions(-)
```

Los dos primeros resultados vacios muestran que las reglas del contador y el acceso a datos no dependen del administrador de estado. La diferencia esta en `presentation`, que es la parte que se reemplaza al cambiar de `setState` a Riverpod o Cubit. Para sustituir Riverpod, se reescribe la presentacion y se conservan el dominio y los datos.

### 5. ¿Que elegiria para una o para ocho pantallas?

Para una pantalla con estado local elegiria `setState`, porque resuelve el problema con poco codigo. Para ocho pantallas que comparten cinco datos elegiria Riverpod o Cubit, para centralizar el estado y hacer explicitas las actualizaciones.

`setState` es la opcion correcta cuando el estado pertenece a un widget o a una pantalla pequena y no necesita compartirse. Cuando el estado debe coordinar varias pantallas, un administrador dedicado evita pasar valores manualmente por toda la navegacion.

## Parte B

### 6. ¿Por que la pantalla Future siguio mostrando Wi-Fi?

En el demo, la pestaña Con Stream muestra Wi-Fi al inicio; al apagar la red, cambia sola a Sin conexion alrededor del segundo 5 y aumenta el contador de cambios. Con Future no se hace ese seguimiento: muestra el resultado de la ultima consulta hasta pulsar Consultar ahora. Si sigue mostrando Wi-Fi despues de apagarlo, no es un dato incorrecto, sino una lectura que quedo vieja cuando cambio la red.

### 7. ¿Que ocurriria sin cancelar la suscripcion del Cubit?

El Cubit dejaria activo el listener del stream al cerrarse. Si se crean y cierran cubits repetidamente, las suscripciones pueden seguir recibiendo eventos, retener objetos y provocar emisiones duplicadas y consumo innecesario de recursos. `close()` cancela la suscripcion para liberar ese listener.

### 8. ¿Por que Future es una foto y Stream una pelicula?

Al consultar con Future, la aplicacion obtiene una sola lectura de la red, por ejemplo “Wi-Fi” a las 10:15. Si se apaga el Wi-Fi despues, la pantalla conserva esa lectura hasta consultar otra vez. Con Stream, el sistema notifica los cambios y la pantalla puede pasar sola a “Sin conexion” o “Datos moviles” mientras permanece abierta.

Pediria con Future el perfil de usuario al iniciar sesion y el resultado de una busqueda. Observaria con Stream la conectividad de red y la ubicacion GPS en tiempo real.

## Comparativa de Parte A

| | setState | Riverpod | Cubit |
|---|---|---|---|
| ¿Donde vive el contador? | En el `State` de la pantalla visor. | En el estado del provider. | En el estado del `ContadorCubit`. |
| ¿Las pantallas se pasan datos? | Si, por constructor y resultado de navegacion. | No. | No. |
| Archivos de `presentation/` que cambian | `pantalla_visor.dart`, `pantalla_control.dart`. | `contador_provider.dart`, `pantalla_visor.dart`, `pantalla_control.dart`. | `contador_cubit.dart`, `pantalla_visor.dart`, `pantalla_control.dart`. |
| ¿Que pasa con el boton atras? | El visor no recibe el valor si no vuelve por la ruta que retorna el resultado. | El estado compartido conserva el cambio. | El estado compartido conserva el cambio. |
| ¿Se modifica `domain/`? | No. | No. | No. |