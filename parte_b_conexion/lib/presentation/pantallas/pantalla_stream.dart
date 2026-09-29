import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/estado_conexion.dart';
import '../estado/conexion_cubit.dart';

class PantallaStream extends StatefulWidget {
  const PantallaStream({super.key});

  @override
  State<PantallaStream> createState() => _PantallaStreamState();
}

class _PantallaStreamState extends State<PantallaStream> {
  int _cambios = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConexionCubit, EstadoConexion>(
      listener: (context, estado) {
        setState(() {
          _cambios++;
        });
      },
      builder: (context, estado) {
        final texto = switch (estado) {
          EstadoConexion.wifi => 'Wi‑Fi',
          EstadoConexion.datosMoviles => 'Datos moviles',
          EstadoConexion.otro => 'Otro',
          EstadoConexion.sinConexion => 'Sin conexion',
        };

        final color = estado == EstadoConexion.sinConexion
            ? Colors.red
            : Colors.green;

        return Scaffold(
          appBar: AppBar(title: const Text('Con Stream')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  estado == EstadoConexion.sinConexion
                      ? Icons.signal_wifi_off
                      : Icons.signal_wifi_statusbar_4_bar,
                  size: 64,
                  color: color,
                ),
                const SizedBox(height: 20),
                Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Cambios recibidos: $_cambios',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
