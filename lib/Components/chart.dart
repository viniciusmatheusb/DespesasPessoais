import 'package:despesaspessoais/Components/chart_bar.dart';
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
        bool mesmoDia = transacoesRecentes[i].date.day == diasDaSemana.day;
        bool mesmoMes = transacoesRecentes[i].date.month == diasDaSemana.month;
        bool mesmoAno = transacoesRecentes[i].date.year == diasDaSemana.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          totalDia += transacoesRecentes[i].value;
        }
      }

      return {
        "day": DateFormat.E().format(diasDaSemana)[0],
        "valor": totalDia,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: grupoDeTransacoes.map((data) {
          return Chart_Bar(
            label: data['day'].toString(),
            value: 2,
            percentage: 0,
          );
        }).toList(),
      ),
    );
  }
}
