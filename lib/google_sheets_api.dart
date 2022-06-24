import 'package:gsheets/gsheets.dart';

class GoogleSheetApi {
  static const _credential = r'''
{

paste the json file


}''';

  //to set up connection
  static final _spreadsheetid = '';
  static final _gsheet = GSheets(_credential);
  static Worksheet? _worksheet;

  //variables for spreadsheet
  static int numberOfTransaction = 0;
  static bool loading = true;
  static List<List<dynamic>> current_transactions = [];

  //future init function

  Future init() async {
    final ss = await _gsheet.spreadsheet(_spreadsheetid);
    _worksheet = ss.worksheetByTitle("Worksheet1");
    countrow();
  }

  //counting the note
  static Future countrow() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransaction + 1)) !=
        '') {
      numberOfTransaction++;
    }
    loadtransaction();
  }

  static Future loadtransaction() async {
    if (_worksheet == null) {
      return;
    }
    for (int i = 1; i < numberOfTransaction; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);

      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);

      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (current_transactions.length < numberOfTransaction) {
        current_transactions
            .add([transactionName, transactionAmount, transactionType]);
      }
    }
    print(current_transactions);
  
    loading = false;
  }

  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransaction++;
    current_transactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < current_transactions.length; i++) {
      if (current_transactions[i][2] == 'income') {
        totalIncome += double.parse(current_transactions[i][1]);
      }
    }

    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;

    for (int i = 0; i < current_transactions.length; i++) {
      if (current_transactions[i][2] == 'expense') {
        totalExpense += double.parse(current_transactions[i][1]);
      }
    }
   
    return totalExpense;
  }
}
