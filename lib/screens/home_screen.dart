import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/database/transaction_db.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'EditForm.dart';

// import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List users = [];
  loadusers() async {
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  void initState() {
    // TODO: implement initState
    loadusers();
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange[300],
          title: Text("data"),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  SystemNavigator.pop();
                })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget child) {
            var count = provider.transactions.length; //นับจำนวนข้อมูล
            if (count <= 0) {
              return Center(
                child: Text(
                  "no data",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      elevation: 8,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(" Name : ${data.title}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(" LastName : ${data.lastname}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(" Address : ${data.address}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        " Tell : ${data.amount.toInt().toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(" Email : ${data.email}"),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: 80,
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.deepOrange[300]),
                                      onPressed: () {
                                        provider
                                            .removeTransaction(
                                                Transactions(email: data.email))
                                            .whenComplete(() {
                                          Provider.of<TransactionProvider>(
                                                  context,
                                                  listen: false)
                                              .initData();
                                        });
                                      },
                                      child: Text('delete')),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        ));
  }
}
