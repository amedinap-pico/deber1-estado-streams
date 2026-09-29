import 'dart:core';

import 'package:flutter/material.dart';

import '../../domain/entities/estado_conexion.dart';
import '../../domain/usecases/consultar_conexion.dart';

class PantallaFoto extends StatefulWidget {
  const PantallaFoto({super.key, required this.consultarConexion});

  final ConsultarConexion consultarConexion;

  @override
  State<PantallaFoto> createState() => _PantallaFotoState();
}

class _PantallaFotoState extends State<PantallaFoto> {
  EstadoConexion _estado = EstadoConexion.otro;
  String _hora = '---';

  Future<void> _consultar() async {
    final resultado = await widget.consultarConexion();
    if (!mounted) return;

    setState(() {
      _estado = resultado;
      _hora = TimeOfDay.now().format(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final texto = switch (_estado) {
      EstadoConexion.wifi => 'Wi‑Fi',
      EstadoConexion.datosMoviles => 'Datos moviles',
      EstadoConexion.otro => 'Otro',
      EstadoConexion.sinConexion => 'Sin conexion',
    };

    final color = _estado == EstadoConexion.sinConexion
        ? Colors.red
        : Colors.green;

    return Scaffold(
      appBar: AppBar(title: const Text('Con Future')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _estado == EstadoConexion.sinConexion
                  ? Icons.signal_wifi_off
                  : Icons.wifi,
              size: 60,
              color: color,
            ),
            const SizedBox(height: 20),
            Text(
              texto,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Hora: $_hora', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _consultar,
              child: const Text('Consultar ahora'),
            ),
          ],
        ),
      ),
    );
  }
}
