import 'dart:async';
import 'dart:ui';
import 'package:flutter/gestures.dart';

import 'Loadingcirlce.dart';

import 'package:flutter/material.dart';
import 'package:personal_financial_patner/google_sheets_api.dart';
import 'package:personal_financial_patner/top_card.dart';
import 'package:personal_financial_patner/transaction.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //dialogue box variables and controller
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _income = false;

  bool Time_has_stared = false;

  void startLoading() {
    Time_has_stared = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

//enter the transcation to the google sheet

  void _enterTransaction() {
    GoogleSheetApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _income,
    );
    setState(() {
      _income = false;
    });
  }

//new transaction
  void new_Transaction() {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AlertDialog(
                    title: Text("new transaction"),
                    backgroundColor: Colors.white.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("expense"),
                              Switch(
                                  activeColor: Colors.green,
                                  value: _income,
                                  autofocus: true,
                                  dragStartBehavior: DragStartBehavior.start,
                                  onChanged: (newvalue) {
                                    setState(() {
                                      _income = newvalue;
                                    });
                                  }),
                              Text("income")
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "enter the amount"),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'enter the amount';
                                        }
                                        return null;
                                      },
                                      controller: _textcontrollerAMOUNT,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Form(
                                    child: TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "for what?"),
                                  controller: _textcontrollerITEM,
                                )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              _income = false;
                            });
                          },
                          child: Text("cancel"),
                          style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.indigo),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey.shade800),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _enterTransaction();
                              Navigator.of(context).pop();
                              _textcontrollerAMOUNT.clear();
                              _textcontrollerITEM.clear();
                            }
                          },
                          child: Text("Enter"),
                          style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.indigo),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey.shade800),
                          ))
                    ],
                  )),
            ));
  }

  get income => GoogleSheetApi.calculateIncome().toString();
  get expense => GoogleSheetApi.calculateExpense().toString();
  get balance =>
      (GoogleSheetApi.calculateIncome() - GoogleSheetApi.calculateExpense())
          .toString();

  @override
  Widget build(BuildContext context) {
    if ((GoogleSheetApi.loading == true) && (Time_has_stared == false)) {
      startLoading();
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TopNeuCard(
                balance: balance,
                income: income,
                expense: expense,
              ),
              Expanded(
                  child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GoogleSheetApi.loading == true
                            ? LoadingCircle()
                            : ListView.builder(
                                itemCount:
                                    GoogleSheetApi.current_transactions.length,
                                itemBuilder: (context, index) {
                                  return transaction(
                                      transactionName: GoogleSheetApi
                                          .current_transactions[index][0],
                                      money: GoogleSheetApi
                                          .current_transactions[index][1],
                                      expenseOrincome: GoogleSheetApi
                                          .current_transactions[index][2]);
                                },
                              ),
                      )
                    ],
                  ),
                ),
              )),
              SizedBox(
                height: 75,
                width: 75,
                child: FloatingActionButton(
                  onPressed: () {
                    new_Transaction();
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.grey.shade500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
