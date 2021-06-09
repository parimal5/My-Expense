import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TranscationList extends StatelessWidget {
  final List<Transcation> transaction;

  TranscationList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transaction.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction added it',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 30),
                Container(
                    height: 300,
                    child: Image.asset(
                      'assets/img/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '₹ ${transaction[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transaction[index].title,
                              style: Theme.of(context).textTheme.headline6),
                          Text(
                            DateFormat.yMMMd().format(transaction[index].date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
