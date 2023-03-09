import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'transaction_card.dart';
import 'add_transaction.dart';
import 'chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test_app',
      theme: ThemeData(primarySwatch: Colors.green, accentColor: Colors.amber),
      home: const Expense(),
    );
  }
}

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final heightofappbar = AppBar().preferredSize.height;
  bool showchart = false;
  List<Transaction> get recenttransaction {
    return values.where((e) {
      return e.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  List<Transaction> values = [];
  void addnew(String title, double amount, DateTime date) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      values.add(newtx);
    });
  }

  void startaddtransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransaction(addNew: addnew);
        });
  }

  void deletetransaction(String id) {
    setState(() {
      values.removeWhere((e) => e.id == id);
    });
  }

  getRemaingHeight(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double appBarHeight = 70;
    double bottomNavHeight = kBottomNavigationBarHeight;
    height = height - appBarHeight - bottomNavHeight;
    return height;
  }

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double remainingHeight = getRemaingHeight(context);
    final transactionlistwidget = SizedBox(
        height: remainingHeight * 0.8,
        child: Transactioncard(
          values: values,
          deletefunction: deletetransaction,
        ));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          startaddtransaction(context);
        }),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("Expense Manager")),
      body: SingleChildScrollView(
          child: islandscape
              ? Container(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Show Chart"),
                        Switch(
                            value: showchart,
                            onChanged: (val) {
                              setState(() {
                                showchart = val;
                              });
                            })
                      ],
                    ),
                    showchart
                        ? SizedBox(
                            height: remainingHeight * 0.8,
                            child: Chart(recenttransaction: recenttransaction))
                        : transactionlistwidget
                  ]),
                )
              : Column(
                  children: [
                    SizedBox(
                        height: remainingHeight * 0.2,
                        child: Chart(recenttransaction: recenttransaction)),
                    transactionlistwidget
                  ],
                )),
    );
  }
}
