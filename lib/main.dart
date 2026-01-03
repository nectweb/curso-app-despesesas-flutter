import 'package:expenses/components/transaction_user.dart';
import 'package:flutter/material.dart';

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
  MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aplicativo de Despesas!")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.all(10),
              child: Card(child: Text("Card de Gráfico")),
            ),
            TransactionUser(),
          ],
        ),
      ),
    );
  }
}
