import 'package:flutter/material.dart';
import 'models/transaction.dart';

class Transactioncard extends StatelessWidget {
  final List<Transaction> values;
  final Function deletefunction;
  const Transactioncard(
      {super.key, required this.values, required this.deletefunction});

  @override
  Widget build(BuildContext context) {
    return values.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: constrains.maxHeight * 0.2,
                  child: const Text(
                    "BROKE ??",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                    height: constrains.maxHeight * 0.8,
                    child: Image.asset('assets/images/waiting.png'))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: ((context, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                  leading: FittedBox(
                      child: CircleAvatar(
                    radius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('₹ ${values[index].amount}'),
                      ),
                    ),
                  )),
                  title: Text(values[index].title),
                  subtitle: Text(values[index].date.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deletefunction(values[index].id),
                  ),
                ),
              );
            }),
            itemCount: values.length,
          );
  }
}
