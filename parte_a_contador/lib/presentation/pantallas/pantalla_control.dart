import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../estado/contador_cubit.dart';

class PantallaControl extends StatelessWidget {
  const PantallaControl({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContadorCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Control')),
      body: Center(
        child: BlocBuilder<ContadorCubit, int>(
          builder: (context, contador) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contador: $contador', style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: cubit.incrementar,
                    child: const Text('+1'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: cubit.decrementar,
                    child: const Text('-1'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
