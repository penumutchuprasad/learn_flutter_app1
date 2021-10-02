import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransactionHandler;

  NewTransaction(this.onAddTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmitted() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.onAddTransactionHandler(enteredTitle, enteredAmount);

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              keyboardType: TextInputType.text,
              // style: TextStyle(color: Colors.purple),
              controller: titleController,
              onSubmitted: (_) => onSubmitted(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              controller: amountController,
              onSubmitted: (_) => onSubmitted(),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
              ),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              color: Colors.blueAccent,
              onPressed: onSubmitted,
            )
          ],
        ),
      ),
    );
  }
}
