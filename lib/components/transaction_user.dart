import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transactions_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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

  void _addTransactions(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      date: DateTime.now(),
      value: value,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionsList(transactions: _transactions),
        TransactionForm(onSubmit: _addTransactions),
      ],
    );
  }
}
