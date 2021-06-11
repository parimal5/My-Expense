import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final String lable;
  final double spendingAmount;
  final double spendingPercOfTotal;

  ChartBars(this.lable, this.spendingAmount, this.spendingPercOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrain) {
      return Column(
        children: [
          Container(
            height: 20,
            child: FittedBox(
              child: Text('₹ ${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: constrain.maxHeight * 0.7,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(lable),
        ],
      );
    });
  }
}
