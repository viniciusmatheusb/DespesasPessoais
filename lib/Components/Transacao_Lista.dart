// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:despesaspessoais/Models/Transacao.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TransacaoLista extends StatelessWidget {
  List<Transacao>? transacoes = [];

  TransacaoLista({
    this.transacoes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transacoes!.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "Nenhuma Transação Cadastrada",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "Assets/Images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transacoes!.length,
              itemBuilder: (context, index) {
                final e = transacoes![index];
                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('R\$ ${e.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      e.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(e.date),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
