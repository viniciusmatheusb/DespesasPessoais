import 'package:flutter/material.dart';

class Chart_Bar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  Chart_Bar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('R\$ ${value.toStringAsFixed(2)}'),
        const SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
