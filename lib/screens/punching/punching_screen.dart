import 'package:flutter/material.dart';
import '../../widgets/production_table.dart';

class VMCScreen extends StatelessWidget {
  const VMCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VMC Machine")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ProductionTable(onQuantityChanged: (value) {}),
      ),
    );
  }
}
