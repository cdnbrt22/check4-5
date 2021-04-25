import 'package:flutter/foundation.dart';
import 'package:flutter_database/database/transaction_db.dart';
import 'package:flutter_database/models/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbnames: "transactions.db");

    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbnames: "transactions.db");

    await db.InsertData(statement);

    transactions = await db.loadAllData();

    notifyListeners();
  }

  removeTransaction(Transactions statement) async {
    var db = TransactionDB(dbnames: "transactions.db");

    await db.removeUser(statement);
    notifyListeners();
  }
}
