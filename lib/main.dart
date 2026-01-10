import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transactions_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Expenses());
}

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.amber,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.purple,
          secondary: Colors.purple,
          seedColor: Colors.amber,
        ),
        fontFamily: 'Montserrat',
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Transaction> _transactions = [];
  bool _showGrafic = true;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addTransactions(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      date: date,
      value: value,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _openModalTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransactions);
      },
    );
  }

  void _removeTransactions(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        "Aplicativo de Despesas",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20 * MediaQuery.textScalerOf(context).scale(1),
        ),
      ),
      actions: [
        if (isLandscape)
          IconButton(
            iconSize: 29 * MediaQuery.textScalerOf(context).scale(1),
            onPressed: () {
              setState(() {
                _showGrafic = !_showGrafic;
              });
            },
            icon: Icon(_showGrafic ? Icons.show_chart : Icons.list),
            style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
          ),
        IconButton(
          iconSize: 29 * MediaQuery.textScalerOf(context).scale(1),
          onPressed: () => _openModalTransaction(context),
          icon: Icon(Icons.add),
          style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
        ),
      ],
    );

    final heightAvailable =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: [
                // if (isLandscape)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text("Exibir Gráfico: "),
                //       Switch(
                //         value: _showGrafic,
                //         onChanged: (value) {
                //           setState(() {
                //             _showGrafic = value;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                if (_showGrafic || !isLandscape)
                  SizedBox(
                    height: heightAvailable * (isLandscape ? 0.7 : 0.25),
                    child: Chart(_recentTransactions),
                  ),
                if (!_showGrafic || !isLandscape)
                  SizedBox(
                    height: heightAvailable * 0.75,
                    child: TransactionsList(
                      transactions: _transactions.reversed.toList(),
                      removeTransactions: _removeTransactions,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModalTransaction(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(100)),
        ),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
