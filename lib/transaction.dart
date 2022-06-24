import 'package:flutter/material.dart';

class transaction extends StatelessWidget {
  transaction(
      {required this.transactionName,
      required this.money,
      required this.expenseOrincome});

  final String transactionName;
  final String money;
  final String expenseOrincome;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(padding: EdgeInsets.all(10),
        height: 60,
        color: Colors.grey.shade200,
        child: Center(

          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            
            Row(
              children: [expenseOrincome=="expense"?Icon(Icons.arrow_downward,color: Colors.red,):Icon(Icons.arrow_upward,color: Colors.green,),
                Text(transactionName),
              ],
            ),Text((expenseOrincome=="expense"?'- ':'+ ') + '₹'+money,
          style: TextStyle(color:expenseOrincome=="expense"?Colors.red:Colors.green),)],),
        ),),
      ),
    );
  }
}
