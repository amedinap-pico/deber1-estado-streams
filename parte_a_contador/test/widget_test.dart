import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:parte_a_contador/domain/repositories/contador_repository.dart';
import 'package:parte_a_contador/domain/usecases/decrementar.dart';
import 'package:parte_a_contador/domain/usecases/incrementar.dart';
import 'package:parte_a_contador/domain/usecases/obtener_contador.dart';
import 'package:parte_a_contador/presentation/pantallas/pantalla_visor.dart';

class FakeContadorRepository implements ContadorRepository {
  int valor = 0;

  @override
  Future<int> leer() async => valor;

  @override
  Future<void> guardar(int valor) async {
    this.valor = valor;
  }
}

void main() {
  testWidgets('setState recibe el contador al volver de Control', (
    tester,
  ) async {
    final repository = FakeContadorRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: PantallaVisor(
          obtenerContador: ObtenerContador(repository),
          casoIncrementar: Incrementar(repository),
          casoDecrementar: Decrementar(repository),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.text('Ir a Control'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('+1'));
    await tester.pumpAndSettle();
    expect(find.text('Contador: 1'), findsOneWidget);
    expect(repository.valor, 1);

    await tester.tap(find.text('Volver'));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
  });
}
