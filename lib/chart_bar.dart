import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double totalspendingamount;
  const Chartbar(
      {super.key,
      required this.label,
      required this.spendingamount,
      required this.totalspendingamount});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        children: [
          Expanded(child: SizedBox()),
          SizedBox(
            height: constrains.maxHeight * 0.15,
            child: FittedBox(child: Text(spendingamount.toString())),
          ),
          SizedBox(height: constrains.maxHeight * 0.05),
          SizedBox(
            height: constrains.maxHeight * 0.5,
            width: 10,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
              ),
              FractionallySizedBox(
                heightFactor: totalspendingamount.toDouble(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25)),
                ),
              )
            ]),
          ),
          SizedBox(height: constrains.maxHeight * 0.05),
          Container(height: constrains.maxHeight * 0.15, child: Text(label)),
          Expanded(child: SizedBox()),
        ],
      );
      ;
    });
  }
}
