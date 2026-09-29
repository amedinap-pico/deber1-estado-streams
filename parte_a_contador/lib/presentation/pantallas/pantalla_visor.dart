import 'package:flutter/material.dart';

import '../../domain/usecases/decrementar.dart';
import '../../domain/usecases/incrementar.dart';
import '../../domain/usecases/obtener_contador.dart';
import 'pantalla_control.dart';

class PantallaVisor extends StatefulWidget {
  const PantallaVisor({
    super.key,
    required this.obtenerContador,
    required this.casoIncrementar,
    required this.casoDecrementar,
  });

  final ObtenerContador obtenerContador;
  final Incrementar casoIncrementar;
  final Decrementar casoDecrementar;

  @override
  State<PantallaVisor> createState() => _PantallaVisorState();
}

class _PantallaVisorState extends State<PantallaVisor> {
  int _contador = 0;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    final valor = await widget.obtenerContador.call();
    if (!mounted) return;
    setState(() => _contador = valor);
  }

  Future<void> _abrirControl() async {
    final valor = await Navigator.push<int>(
      context,
      MaterialPageRoute<int>(
        builder: (_) => PantallaControl(
          contador: _contador,
          casoIncrementar: widget.casoIncrementar,
          casoDecrementar: widget.casoDecrementar,
        ),
      ),
    );
    if (valor != null && mounted) {
      setState(() => _contador = valor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Contador:', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 12),
            Text(
              '$_contador',
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _abrirControl,
              child: const Text('Ir a Control'),
            ),
          ],
        ),
      ),
    );
  }
}
