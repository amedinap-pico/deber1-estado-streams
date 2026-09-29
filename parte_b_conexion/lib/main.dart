import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/conexion_plus_repository.dart';
import 'domain/usecases/consultar_conexion.dart';
import 'domain/usecases/observar_conexion.dart';
import 'presentation/estado/conexion_cubit.dart';
import 'presentation/pantallas/pantalla_foto.dart';
import 'presentation/pantallas/pantalla_stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ConexionPlusRepository();
    final consultarConexion = ConsultarConexion(repository);
    final observarConexion = ObservarConexion(repository);

    return MaterialApp(
      title: 'Estado de conexión',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Conexión'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Con Future'),
                Tab(text: 'Con Stream'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PantallaFoto(consultarConexion: consultarConexion),
              BlocProvider(
                create: (_) => ConexionCubit(
                  consultarConexion: consultarConexion,
                  observarConexion: observarConexion,
                )..iniciar(),
                child: const PantallaStream(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
