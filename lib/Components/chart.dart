import 'dart:math';

import 'package:despesaspessoais/Components/Chart_Bar.dart';
import 'package:despesaspessoais/Models/Transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transacao> transacoesRecentes;

  Chart({super.key, required this.transacoesRecentes});

  List<Map<String, dynamic>> get grupoDeTransacoes {
    return List.generate(7, (index) {
      final diasDaSemana = DateTime.now().subtract(Duration(days: index));

      DateFormat.EEEE('pt_BR').format(diasDaSemana)[0];

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
        "day": DateFormat.E('pt_BR').format(diasDaSemana).toUpperCase(),
        "valor": totalDia,
      };
    }).reversed.toList();
  }

  double get _weekTotalValor {
    return grupoDeTransacoes.fold<double>(0.0, (soma, item) {
      return soma + (item['valor'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grupoDeTransacoes.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'].toString(),
                value: (data['valor'] as double),
                percentage: _weekTotalValor == 0
                    ? 0
                    : (data['valor'] as double) / _weekTotalValor,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
