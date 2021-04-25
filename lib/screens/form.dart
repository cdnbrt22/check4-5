import 'package:flutter/material.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  double padding = 8;

  final titleController = TextEditingController();
  final lastnameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Register"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            key: formKey,
            child: SizedBox(
              child: ListView(
                children: [
                  TextFormField(
                    decoration: new InputDecoration(labelText: "Name"),
                    controller: titleController,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "Enter your name plase";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "Last name"),
                    controller: lastnameController,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "Enter your last name plase";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "Address"),
                    controller: addressController,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "Enter your address plase";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(labelText: "Phone"),
                    controller: amountController,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "Phone";
                      }
                      if (double.parse(str) <= 0) {
                        return "Enter your number phone";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(labelText: "E-mail"),
                    controller: emailController,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "Enter your e-mail plase";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(labelText: "Password"),
                    controller: passwordController,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "Enter your password plase";
                      }
                      return null;
                    },
                  ),
                  Column(
                    children: [
                      RaisedButton(
                        child: Text("Submit"),
                        color: Colors.blueGrey[200],
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            var title = titleController.text.trim();
                            var lastname = lastnameController.text.trim();
                            var address = addressController.text.trim();
                            var amount = amountController.text.trim();
                            var email = emailController.text.trim();
                            var password = passwordController.text.trim();

                            Transactions statement = Transactions(
                                title: title,
                                lastname: lastname,
                                address: address,
                                amount: double.parse(amount),
                                email: email,
                                password: password,
                                date: DateTime.now());

                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            provider.addTransaction(statement);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) {
                                      return MyHomePage();
                                    }));
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
