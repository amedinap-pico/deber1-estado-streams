import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../estado/contador_provider.dart';
import 'pantalla_control.dart';

class PantallaVisor extends ConsumerWidget {
  const PantallaVisor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contador = ref.watch(contadorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Visor')),
      body: contador.when(
        data: (valor) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Contador:', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 12),
              Text(
                '$valor',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const PantallaControl(),
                  ),
                ),
                child: const Text('Ir a Control'),
              ),
            ],
          ),
        ),
        error: (error, _) => Center(child: Text('Error al cargar: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
