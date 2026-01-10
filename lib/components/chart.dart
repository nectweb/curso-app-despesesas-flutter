import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double get _wekkeDayTotal {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 7,
              children: groupedTransactions.map((tr) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tr['day'].toString(),
                    value: double.parse(tr['value'].toString()),
                    percentage: _wekkeDayTotal == 0
                        ? 0
                        : (tr['value'] as double) / _wekkeDayTotal,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
