import 'package:despesaspessoais/Models/Transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transacao> transacoesRecentes;

  Chart({super.key, required this.transacoesRecentes});

  List<Map<String, Object>> get grupoDeTransacoes {
    return List.generate(7, (index) {
      final diasDaSemana = DateTime.now().subtract(Duration(days: index));

      DateFormat.E().format(diasDaSemana)[0];

      double totalDia = 0;

      for (var i = 0; i < transacoesRecentes.length; i++) {
        bool mesmoDia = transacoesRecentes[i].date.day == diasDaSemana;
        bool mesmoMes = transacoesRecentes[i].date.month == diasDaSemana;
        bool mesmoAno = transacoesRecentes[i].date.year == diasDaSemana;
      }

      return {
        "day": DateFormat.E().format(diasDaSemana)[0],
        "valor": 9.99,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
