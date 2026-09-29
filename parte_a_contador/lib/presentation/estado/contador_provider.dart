import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/contador_prefs_repository.dart';
import '../../domain/repositories/contador_repository.dart';
import '../../domain/usecases/decrementar.dart';
import '../../domain/usecases/incrementar.dart';
import '../../domain/usecases/obtener_contador.dart';

final contadorRepositoryProvider = Provider<ContadorRepository>(
  (ref) => ContadorPrefsRepository(),
);

final contadorProvider = AsyncNotifierProvider<ContadorNotifier, int>(
  ContadorNotifier.new,
);

class ContadorNotifier extends AsyncNotifier<int> {
  @override
  Future<int> build() {
    final repository = ref.watch(contadorRepositoryProvider);
    return ObtenerContador(repository).call();
  }

  Future<void> incrementar() async {
    final repository = ref.read(contadorRepositoryProvider);
    state = await AsyncValue.guard(() => Incrementar(repository).call());
  }

  Future<void> decrementar() async {
    final repository = ref.read(contadorRepositoryProvider);
    state = await AsyncValue.guard(() => Decrementar(repository).call());
  }
}
