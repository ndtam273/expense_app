import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions) {
    print('Constructor Chart');
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
        print('build() Chart');

    print(groupedTransactionValues);
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    maxSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / maxSpending),
              );
            }).toList()),
      ),
    );
  }
}
