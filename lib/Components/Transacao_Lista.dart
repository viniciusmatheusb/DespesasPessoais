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
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'R\$ ${e.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            e.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            /*const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),*/
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(e.date),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
