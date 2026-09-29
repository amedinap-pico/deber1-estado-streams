import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:parte_a_contador/domain/repositories/contador_repository.dart';
import 'package:parte_a_contador/domain/usecases/decrementar.dart';
import 'package:parte_a_contador/domain/usecases/incrementar.dart';
import 'package:parte_a_contador/domain/usecases/obtener_contador.dart';
import 'package:parte_a_contador/presentation/estado/contador_cubit.dart';
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
  testWidgets('Cubit comparte y persiste el contador entre pantallas', (
    tester,
  ) async {
    final repository = FakeContadorRepository();
    final cubit = ContadorCubit(
      obtenerContador: ObtenerContador(repository),
      casoIncrementar: Incrementar(repository),
      casoDecrementar: Decrementar(repository),
    );

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: PantallaVisor()),
      ),
    );
    await cubit.cargar();
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

    await cubit.close();
  });
}
