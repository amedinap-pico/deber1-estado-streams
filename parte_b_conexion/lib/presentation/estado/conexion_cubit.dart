import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/estado_conexion.dart';
import '../../domain/usecases/consultar_conexion.dart';
import '../../domain/usecases/observar_conexion.dart';

class ConexionCubit extends Cubit<EstadoConexion> {
  ConexionCubit({
    required this.consultarConexion,
    required this.observarConexion,
  }) : super(EstadoConexion.otro);

  final ConsultarConexion consultarConexion;
  final ObservarConexion observarConexion;

  StreamSubscription<EstadoConexion>? _subscription;

  Future<void> iniciar() async {
    final estadoActual = await consultarConexion();
    emit(estadoActual);

    _subscription?.cancel();
    _subscription = observarConexion().listen((estado) {
      emit(estado);
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
