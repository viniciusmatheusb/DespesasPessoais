import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoForm extends StatefulWidget {
  final void Function(String, double, DateTime)? onSubmit;

  const TransacaoForm({
    super.key,
    this.onSubmit,
  });

  @override
  State<TransacaoForm> createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();
  DateTime? _data = DateTime.now();

  _submitForm() {
    final titulo = _tituloController.text;
    final valor = double.parse(_valorController.text);

    if (titulo.isEmpty || valor <= 0) {
      return;
    }

    widget.onSubmit!(titulo, valor, _data!);
    Navigator.of(context).pop();
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((dataSelecionada) {
      if (dataSelecionada == null) return null;

      setState(() {
        _data = dataSelecionada;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _valorController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Valor(R\$)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_data == null
                      ? 'Nenhuma data selecionada'
                      : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_data!)}'),
                ),
                ElevatedButton(
                  onPressed: _showDatePicker,
                  child: const Text(
                    'Selecione a data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                  ),
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
