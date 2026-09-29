import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parte_b_conexion/domain/entities/estado_conexion.dart';
import 'package:parte_b_conexion/domain/repositories/conexion_repository.dart';
import 'package:parte_b_conexion/domain/usecases/consultar_conexion.dart';
import 'package:parte_b_conexion/domain/usecases/observar_conexion.dart';
import 'package:parte_b_conexion/presentation/estado/conexion_cubit.dart';
import 'package:parte_b_conexion/presentation/pantallas/pantalla_foto.dart';

class FakeConexionRepository implements ConexionRepository {
  FakeConexionRepository(this.estadoActual);

  final EstadoConexion estadoActual;
  final StreamController<EstadoConexion> cambios =
      StreamController<EstadoConexion>.broadcast(sync: true);

  @override
  Future<EstadoConexion> consultarAhora() async => estadoActual;

  @override
  Stream<EstadoConexion> observarCambios() => cambios.stream;
}

void main() {
  testWidgets('Future muestra el resultado al consultar', (tester) async {
    final repository = FakeConexionRepository(EstadoConexion.wifi);

    await tester.pumpWidget(
      MaterialApp(
        home: PantallaFoto(consultarConexion: ConsultarConexion(repository)),
      ),
    );
    expect(find.text('Otro'), findsOneWidget);

    await tester.tap(find.text('Consultar ahora'));
    await tester.pumpAndSettle();

    expect(find.text('Wi‑Fi'), findsOneWidget);
    expect(find.text('Hora: ---'), findsNothing);
    await repository.cambios.close();
  });

  test('Cubit recibe los cambios del stream de conexion', () async {
    final repository = FakeConexionRepository(EstadoConexion.wifi);
    final cubit = ConexionCubit(
      consultarConexion: ConsultarConexion(repository),
      observarConexion: ObservarConexion(repository),
    );

    try {
      await cubit.iniciar();
      expect(cubit.state, EstadoConexion.wifi);

      repository.cambios.add(EstadoConexion.sinConexion);

      expect(cubit.state, EstadoConexion.sinConexion);
    } finally {
      await cubit.close();
      await repository.cambios.close();
    }
  });
}
