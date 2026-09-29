import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/contador_prefs_repository.dart';
import 'domain/usecases/decrementar.dart';
import 'domain/usecases/incrementar.dart';
import 'domain/usecases/obtener_contador.dart';
import 'presentation/estado/contador_cubit.dart';
import 'presentation/pantallas/pantalla_visor.dart';

void main() {
  Bloc.observer = ContadorObserver();
  final repository = ContadorPrefsRepository();

  runApp(
    BlocProvider(
      create: (_) => ContadorCubit(
        obtenerContador: ObtenerContador(repository),
        casoIncrementar: Incrementar(repository),
        casoDecrementar: Decrementar(repository),
      )..cargar(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PantallaVisor(),
    );
  }
}

class ContadorObserver extends BlocObserver {
  @override
  void onChange(BlocBase<Object?> bloc, Change<Object?> change) {
    super.onChange(bloc, change);
    if (bloc is ContadorCubit) {
      debugPrint(
        '${bloc.runtimeType}: ${change.currentState} -> ${change.nextState}',
      );
    }
  }
}
