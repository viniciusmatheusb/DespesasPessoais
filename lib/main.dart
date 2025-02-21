import 'dart:math';

import 'package:despesaspessoais/Components/Transacao_Form.dart';
import 'package:despesaspessoais/Components/Transacao_Lista.dart';
import 'package:despesaspessoais/Models/Transacao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DespesasPessoais());
}

class DespesasPessoais extends StatelessWidget {
  const DespesasPessoais({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.amber,
            ),
        textTheme: ThemeData().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transacao> _transacoes = [
    Transacao(id: 't1', title: 'Energia', value: 347.50, date: DateTime.now()),
    Transacao(id: 't2', title: 'Água', value: 125.12, date: DateTime.now()),
    Transacao(id: 't3', title: 'Internet', value: 79.90, date: DateTime.now()),
    Transacao(id: 't4', title: 'Celular', value: 29.90, date: DateTime.now()),
  ];

  _addTransacao(String titulo, double valor) {
    final novaTransacao = Transacao(
      id: Random().nextDouble().toString(),
      title: titulo,
      value: valor,
      date: DateTime.now(),
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });
  }

  _abrirModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransacaoForm(
          onSubmit: _addTransacao,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Despesas Pessoais',
          style: TextStyle(),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _abrirModal(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.blue,
                child: Text('Gráfico'),
              ),
            ),
            TransacaoLista(transacoes: _transacoes.toList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _abrirModal(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
