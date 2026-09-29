import 'package:flutter_test/flutter_test.dart';
import 'package:parte_a_contador/domain/usecases/incrementar.dart';
import 'package:parte_a_contador/domain/usecases/decrementar.dart';
import 'package:parte_a_contador/domain/usecases/obtener_contador.dart';
import 'package:parte_a_contador/domain/repositories/contador_repository.dart';

class FakeContadorRepository implements ContadorRepository {
  int _valor = 0;

  @override
  Future<int> leer() async => _valor;

  @override
  Future<void> guardar(int valor) async {
    _valor = valor;
  }
}

void main() {
  group('casos de uso del contador', () {
    test('obtener contador devuelve el valor persistido', () async {
      final repo = FakeContadorRepository();
      await repo.guardar(7);
      final usecase = ObtenerContador(repo);

      expect(await usecase.call(), 7);
    });

    test('incrementar suma 1 al valor guardado', () async {
      final repo = FakeContadorRepository();
      await repo.guardar(4);
      final usecase = Incrementar(repo);

      expect(await usecase.call(), 5);
    });

    test('decrementar resta 1 al valor guardado', () async {
      final repo = FakeContadorRepository();
      await repo.guardar(4);
      final usecase = Decrementar(repo);

      expect(await usecase.call(), 3);
    });
  });
}
