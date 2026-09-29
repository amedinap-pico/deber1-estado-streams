import 'package:flutter/material.dart';

import '../../domain/usecases/decrementar.dart';
import '../../domain/usecases/incrementar.dart';

class PantallaControl extends StatefulWidget {
  const PantallaControl({
    super.key,
    required this.contador,
    required this.casoIncrementar,
    required this.casoDecrementar,
  });

  final int contador;
  final Incrementar casoIncrementar;
  final Decrementar casoDecrementar;

  @override
  State<PantallaControl> createState() => _PantallaControlState();
}

class _PantallaControlState extends State<PantallaControl> {
  late int _contador;

  @override
  void initState() {
    super.initState();
    _contador = widget.contador;
  }

  Future<void> _incrementar() async {
    final valor = await widget.casoIncrementar.call();
    if (mounted) setState(() => _contador = valor);
  }

  Future<void> _decrementar() async {
    final valor = await widget.casoDecrementar.call();
    if (mounted) setState(() => _contador = valor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $_contador', style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementar,
                  child: const Text('+1'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _decrementar,
                  child: const Text('-1'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop<int>(context, _contador),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
