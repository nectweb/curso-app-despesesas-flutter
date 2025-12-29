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
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aplicativo de Despesas!")),
      body: Center(child: Text("Bem vindo ao App!")),
    );
  }
}
