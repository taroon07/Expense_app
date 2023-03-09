import 'package:flutter/material.dart';
import 'chart_bar.dart';

import './models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransaction;
  const Chart({super.key, required this.recenttransaction});
  List<Map<String, Object>> get groupedtransactionvalues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalamount = 0.0;
      for (int i = 0; i < recenttransaction.length; i++) {
        if (recenttransaction[i].date.day == weekday.day &&
            recenttransaction[i].date.month == weekday.month &&
            recenttransaction[i].date.year == weekday.year) {
          totalamount += recenttransaction[i].amount;
        }
      }
      return {'day': weekday.day, 'amount': totalamount};
    });
  }

  double get totalspending {
    return groupedtransactionvalues.fold(0.0, (sum, values) {
      return sum + (values['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: groupedtransactionvalues.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: Chartbar(
                    label: e['day'].toString(),
                    spendingamount: e['amount'] as double,
                    totalspendingamount: totalspending == 0.0
                        ? 0.0
                        : (e['amount'] as double) / totalspending),
              );
            }).toList()),
      ),
    );
  }
}
