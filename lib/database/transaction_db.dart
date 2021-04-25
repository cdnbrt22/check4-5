import 'dart:io';

import 'package:flutter_database/models/Transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //บริการเกียวกับฐานข้อมูล

  String dbnames; //เก็บชื่อฐานข้อมูล

  // ถ้ายังไม่ถูกสร้าง => สร้าง
  // ถูกสร้างไว้แล้ว => เปิด
  TransactionDB({this.dbnames});

  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbnames);
    // สร้าง database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async {
    //ฐานข้อมูล => Store
    // transaction.db => expense
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "title": statement.title,
      "lastname": statement.lastname,
      "address": statement.address,
      "amount": statement.amount,
      "email": statement.email,
      "password": statement.password,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  Future removeUser(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    print(statement.email);
    final finder = Finder(filter: Filter.equals('email', statement.email));
    print(finder);
    final res = await store.delete(db, finder: finder);
    print(res);
    db.close();
  }

  //ดึงข้อมูล

  // ใหม่ => เก่า false มาก => น้อย
  // เก่า => ใหม่ true น้อย => มาก
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List transactionList = List<Transactions>();
    //ดึงมาทีละแถว
    for (var record in snapshot) {
      transactionList.add(Transactions(
          title: record["title"],
          lastname: record["lastname"],
          address: record["address"],
          amount: record["amount"],
          email: record["email"],
          password: record["password"],
          date: DateTime.parse(record["date"])));
    }
    return transactionList;
  }
}
