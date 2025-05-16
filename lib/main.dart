import 'dart:math';

import 'package:despesaspessoais/Components/Transacao_Form.dart';
import 'package:despesaspessoais/Components/Transacao_Lista.dart';
import 'package:despesaspessoais/Components/chart.dart';
import 'package:despesaspessoais/Models/Transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa a formatação para pt_BR
  await initializeDateFormatting('pt_BR');
  Intl.defaultLocale = 'pt_BR';

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
  final List<Transacao> _transacoes = [];

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((transacao) {
      return transacao.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransacao(String titulo, double valor, DateTime data) {
    final novaTransacao = Transacao(
      id: Random().nextDouble().toString(),
      title: titulo,
      value: valor,
      date: data,
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
            Chart(transacoesRecentes: _transacoesRecentes),
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
