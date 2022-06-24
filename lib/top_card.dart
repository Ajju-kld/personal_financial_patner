import 'dart:ui';

import 'package:flutter/material.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;
  TopNeuCard({required this.balance,required this.expense,required this.income});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "B A L A N C E",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              ),
              Text(
                "₹ "+balance,
                style: TextStyle(color: Colors.grey.shade800, fontSize: 40,fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(height: 45,width: 45,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),child: Icon(Icons.arrow_upward,size: 30,color: Colors.green.shade700)),
                      ),
                      Column(
                        children: [Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("income",style: TextStyle(color: Colors.grey.shade500,fontSize: 16)),
                        ), Text("₹ "+income,style: TextStyle(fontSize: 16),)],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 5, 2),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 5, 6),
                          child: Container(height: 45,width:45,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),child: Icon(Icons.arrow_downward,color: Colors.red,size: 30,)),
                        ),
                        Column(
                            children: [Padding(
                              padding: const EdgeInsets.all(4.3),
                              child: Text("expense",style: TextStyle(fontSize: 16,color: Colors.grey.shade500),),
                            ), Text("₹ "+expense,style: TextStyle(fontSize: 16),)],
                          ),
                        
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        height: 200,
        decoration: BoxDecoration(color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
BoxShadow(color:Colors.grey.shade500,
blurRadius: 15.0,
offset: Offset(4.0, 4.0),
spreadRadius: 1.0),
BoxShadow(color:Colors.white,
blurRadius: 15.0,
offset: Offset(-4.0,-4.0),
spreadRadius: 1.0)
        ]),
      ),
    );
  }
}
