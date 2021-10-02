import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? Container(
                height: 300,
                child: Column(
                  children: [
                    Text(
                      'No transaction made yet!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: 200,
                        child: Image.asset(
                          'assets/images/waiting.png',
                        )),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (contxt, index) {
                  final Transaction txn = transactions[index];
                  return Card(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          )),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '\$ ${txn.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              txn.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('hh:mm a -- MMM dd yyyy')
                                  .format(txn.date),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    elevation: 3,
                    shadowColor: Colors.green,
                  );
                },
                itemCount: transactions.length,
              ));
  }
}

/*
Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.purple,
                    width: 2.0,
                  )),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '\$ ${txn.amount}',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      txn.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('hh:mm a -- MMM dd yyyy').format(txn.date),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            elevation: 3,
            shadowColor: Colors.green,
          )
*/
