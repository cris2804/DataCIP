import 'package:flutter/material.dart';

class ParcelaDetailScreen extends StatelessWidget {
  final Map<String, dynamic> properties;

  const ParcelaDetailScreen({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de Parcela')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: properties.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              subtitle: Text(entry.value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
