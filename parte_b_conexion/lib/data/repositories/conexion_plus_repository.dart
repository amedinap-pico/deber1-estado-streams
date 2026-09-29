import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/entities/estado_conexion.dart';
import '../../domain/repositories/conexion_repository.dart';

class ConexionPlusRepository implements ConexionRepository {
  @override
  Future<EstadoConexion> consultarAhora() async {
    final estado = await Connectivity().checkConnectivity();
    return _mapear(estado);
  }

  @override
  Stream<EstadoConexion> observarCambios() {
    return Connectivity().onConnectivityChanged.asyncMap(
      (resultado) => _mapear(resultado),
    );
  }

  EstadoConexion _mapear(List<ConnectivityResult> resultado) {
    if (resultado.contains(ConnectivityResult.wifi)) {
      return EstadoConexion.wifi;
    }
    if (resultado.contains(ConnectivityResult.mobile)) {
      return EstadoConexion.datosMoviles;
    }
    if (resultado.contains(ConnectivityResult.ethernet)) {
      return EstadoConexion.otro;
    }
    return EstadoConexion.sinConexion;
  }
}
