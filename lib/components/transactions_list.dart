import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((tr) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.zero),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
    );
  }
}
