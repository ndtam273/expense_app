import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransaction = [
    Transaction(id: 't1', title: 'new shoes', amount: 99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'new sandal', amount: 39, date: DateTime.now()),
    Transaction(id: 't3', title: 'new car', amount: 9999, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

        setState(() {
          _userTransaction.add(newtx);
        });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransaction),
      ],
    );
  }
}
