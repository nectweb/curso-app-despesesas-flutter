import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Expenses());
}

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Ténis de corrida',
      date: DateTime.now(),
      value: 310.50,
    ),
    Transaction(
      id: 't2',
      title: 'Conta de energia',
      date: DateTime.now(),
      value: 210.30,
    ),
  ];

  MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aplicativo de Despesas!")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsetsDirectional.all(10),
            child: Card(child: Text("Card de Gráfico")),
          ),
          Column(
            children: _transactions.map((tr) {
              return Card(
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.zero),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.purple),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        'R\$ ${tr.value.toStringAsFixed(2).replaceAll('.', ',')}',
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          tr.title,
                        ),
                        Text(
                          style: TextStyle(color: Colors.grey),
                          DateFormat('d MMM y').format(tr.date),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Titulo:"),
                    controller: titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Valor R\$:"),
                    controller: valueController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(0),
                        ),
                        onPressed: () {
                          print(titleController.text);
                          print(valueController.text);
                        },
                        child: Text(
                          'Nova Transação',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
