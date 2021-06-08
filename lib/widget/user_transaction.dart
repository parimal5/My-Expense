import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transcation> _usertransaction = [
    Transcation(
      id: '1',
      title: 'New Shoe',
      amount: 5000,
      date: DateTime.now(),
    ),
    Transcation(
      id: '2',
      title: 'Grocery',
      amount: 200,
      date: DateTime.now(),
    ),
  ];

  void addTransaction(String title, double amount) {
    final newTx = Transcation(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      _usertransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addTransaction),
        TranscationList(_usertransaction),
      ],
    );
  }
}
