import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './widgets/new_transaction.dart';
import './widgets/trasnsaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "id1",
      title: "New Shoes",
      amount: 459,
      date: DateTime.now(),
    ),
    Transaction(
      id: "id2",
      title: "New Shirts",
      amount: 139,
      date: DateTime.now(),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((txn) {
      return txn.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTxn = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.insert(0, newTxn);
    });

    Navigator.of(context).pop(); // is it okay to have here ?
  }

  void _startAddingNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {
              //..
            },
            child: MediaQuery(
              data: MediaQueryData(),
              child: NewTransaction(_addNewTransaction),
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.orange,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("My Expenses"),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () => _startAddingNewTransaction(context),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Chart(_recentTransactions),
                TransactionList(_userTransactions),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddingNewTransaction(context),
          ),
        ),
      ),
    );
  }
}
