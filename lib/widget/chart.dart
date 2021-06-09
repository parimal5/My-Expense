import 'package:expense_tracker/widget/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transcation> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      final weekDays = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDays.day &&
            recentTransaction[i].date.month == weekDays.month &&
            recentTransaction[i].date.year == weekDays.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDays),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupTransactionValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBars(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
