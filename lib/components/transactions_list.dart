import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransactions;

  const TransactionsList({
    super.key,
    required this.transactions,
    required this.removeTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, contrains) {
              return Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Lista vázia no momento",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(2),
                    height: contrains.maxHeight * 0.6,
                    child: Image(
                      image: AssetImage('assets/images/empty.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsetsGeometry.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: FittedBox(
                        child: Text(
                          'R\$${tr.value}',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: IconButton(
                    onPressed: () => removeTransactions(tr.id),
                    color: Colors.red,
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
  }
}
