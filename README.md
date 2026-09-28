# Deber 1: manejo de estado y streams en Flutter

Ejercicio de arquitectura limpia, administracion de estado y observacion de cambios de conectividad.

## Contenido

- `parte_a_contador/`: contador persistente implementado en tres ramas Git: `version/setstate`, `version/riverpod` y `version/bloc`.
- `parte_b_conexion/`: consulta puntual de conectividad con `Future` y seguimiento de cambios con `Stream` y Cubit.
- `RESPUESTAS.md`: respuestas a las ocho preguntas y resultados de la comparacion entre ramas.
- `demo.mp4`: video requerido de la pantalla Stream al cambiar la conexion. Debe grabarse en un telefono o emulador que permita alternar la red; no se incluye una grabacion simulada.

## Arquitectura

Ambas aplicaciones separan `presentation`, `domain` y `data`. El dominio define los contratos y casos de uso; la capa de datos implementa el acceso a SharedPreferences o a `connectivity_plus`; presentacion contiene las pantallas y el administrador de estado.

En Parte A, las tres ramas comparten el mismo dominio y datos. Para comparar una implementacion, entra en `parte_a_contador` y cambia a la rama correspondiente:

```bash
git switch version/setstate
git switch version/riverpod
git switch version/bloc
```

## Ejecutar y verificar

Ejecuta cada aplicacion desde su carpeta:

```bash
cd parte_a_contador
flutter pub get
flutter analyze
flutter test
```

```bash
cd parte_b_conexion
flutter pub get
flutter analyze
```

Para verificar la frontera de arquitectura de Parte B:

```bash
git grep -li connectivity -- 'lib/*.dart' 'lib/**/*.dart'
```

El unico resultado esperado es `lib/data/repositories/conexion_plus_repository.dart`.

## Video de demostracion

Graba entre 15 y 20 segundos en un dispositivo real: abre la pestana `Con Stream`, apaga el Wi-Fi y vuelve a encenderlo sin tocar la aplicacion. Guarda el video como `demo.mp4` en esta carpeta.