import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'widget/transaction_list.dart';
import 'widget/chart.dart';
import 'widget/new_transaction.dart';
import 'models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expense',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transcation> _usertransaction = [
    // Transcation(
    //   id: '1',
    //   title: 'Add Note',
    //   amount: 50,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transcation(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() {
      _usertransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Transcation> get _recentTransaction {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLandsacpe =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('My Expense'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('My Expense'),
            actions: [
              Row(
                children: [
                  if (isLandsacpe)
                    Row(
                      children: [
                        Text(
                          'Chart',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Switch.adaptive(
                            value: _showChart,
                            onChanged: (val) {
                              setState(() {
                                _showChart = val;
                              });
                            }),
                      ],
                    ),
                  IconButton(
                    onPressed: () => _startAddNewTransaction(context),
                    icon: Icon(
                      Icons.add_circle,
                    ),
                  ),
                ],
              )
            ],
          );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isLandsacpe)
              Container(
                  height:
                      (mediaQuery.size.height - appbar.preferredSize.height) *
                          0.3,
                  child: Chart(_recentTransaction)),
            if (!isLandsacpe)
              Container(
                  height:
                      (mediaQuery.size.height - appbar.preferredSize.height) *
                          0.65,
                  child: TranscationList(_usertransaction, _deleteTransaction)),
            if (isLandsacpe)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appbar.preferredSize.height) *
                          0.88,
                      child: Chart(_recentTransaction))
                  : Container(
                      height: (mediaQuery.size.height -
                              appbar.preferredSize.height) *
                          0.8,
                      child: TranscationList(
                          _usertransaction, _deleteTransaction)),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody, navigationBar: appbar)
        : Scaffold(
            appBar: appbar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
