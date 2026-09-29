import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/decrementar.dart';
import '../../domain/usecases/incrementar.dart';
import '../../domain/usecases/obtener_contador.dart';

class ContadorCubit extends Cubit<int> {
  ContadorCubit({
    required this.obtenerContador,
    required this.casoIncrementar,
    required this.casoDecrementar,
  }) : super(0);

  final ObtenerContador obtenerContador;
  final Incrementar casoIncrementar;
  final Decrementar casoDecrementar;

  Future<void> cargar() async {
    emit(await obtenerContador.call());
  }

  Future<void> incrementar() async {
    emit(await casoIncrementar.call());
  }

  Future<void> decrementar() async {
    emit(await casoDecrementar.call());
  }
}
