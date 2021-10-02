import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';
import 'package:my_expenditure_tracker/widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        final recentTxnDate = recentTransactions[i].date;
        if (recentTxnDate.day == weekDay.day &&
            recentTxnDate.month == weekDay.month &&
            recentTxnDate.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    });
  }

  double get totalSpending {
    return _groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(12),
      child: recentTransactions.isEmpty
          ? Container(
              height: 50,
              child: Center(
                child: Text('No data available yet!'),
              ),
            )
          : Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _groupedTransactions.map((data) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: '${data['day']}',
                      spendingAmount: (data['amount'] as double),
                      spendingPcntOfTotal:
                          (data['amount'] as double) / totalSpending,
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
