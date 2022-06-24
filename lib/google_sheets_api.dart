import 'package:gsheets/gsheets.dart';

class GoogleSheetApi {
  static const _credential = r'''
{"type": "service_account",
  "project_id": "financial-patner-app",
  "private_key_id": "d6620878b5d9f20d3f214c9f3a5d2accfe058351",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCU9gVb5OF1SEI/\nn/1UkBamdAZar3/j7dzJn3q3MtPMaB7UpMuIyluIWXbU3WmNgzdxst468PUmtIGF\noI1T8at1Evcs1u9GJi9yGsk3VvEJGI9MFovhxussxrBx8YRHSCMHqAWWRVRVzcEj\n9Fanq+alFMvu/Q8u/e/wMYc8xrTjHGsJUahGevJMpBJMgawrQINplAGmJyNaNqae\ncej3FEtwWwNIjSEQnEAHF+8CIPTVMtzCwUU+pShcam4hfIYgoGAN64tA3U1niYGE\nQnc8gjqd6tbtVVu3oSAte1ZwTSnmtSplKxGdbPJDi7NDLmcxm1wbfzt5E6ED729p\nr5UDGtqvAgMBAAECggEAFaFd6NilBn9OI2gLhLaBm30YmR2H4CSfnWV7j9OhHrr1\n0yH07jGYNgXrtABMvgBSUj/Ldlqb9plaf3lvXEOpBpCQ9OFnEFQmKpcKJe+Jg60d\nzcouWMQmTTOy1nDgKOuoLonu+cGqe+UrSRnHZYSYMtuAu3zisgusxj+i6Cfgh2PV\nyrNtdCFRhzB/rEwmzkx/JNRVq1CdGyZU0rYeSj83Gru9oMhaFpwjBWnLGL7Q3cZ4\nK5OFG0J+rJMdrHLqXe3vO3jYpLXXjIs7X8reAGLu1Jap27XAFHkmqEoe2mipnX7b\nc8+8kHBTBo8gn9qTU7OC7cQq04GNqtoPj4at2sqiYQKBgQDH1Pac/mvFRHHI2JwP\nMSo+y/CvYRfDEeVSVe+MV/iYJ405MKsGYimOjkwguTR0IyWGDUuEdJ0qLQ1ozVsR\nR25sUQXaf7HAGIgyO4qz89xaaOqBcPiZhRZ4v25SxUToJG+ZoCCuxP58+Fmw/faV\nczA9v5HSKdnKyEORxr5CRimHoQKBgQC+1Jw/QIGe1cHKyHa9STGS39rADBqRo1nl\n12uk6DzKyJKZKQ9QcYMSfNmC6/GxCJUblHmDpmKYl8U6LFecxe0YdbPamNU/a72r\nlFsfXw7WF4FBt5ur4JiVxW4bvk5fbRCPJq9RO/eElwK9T6L8k15Iknq0W4y2i/M/\nvaYIEAoATwKBgQCS56Ggyn0J2YZYo70eggNPhPfcxmEEm/xdKiXfo7BykukEOR4R\npEpurXeTuvOvyULFqLJynpQHtHUeLZGcQ0oPQQUvmx5eXOqLGzCdmFHO+UAkhpuL\nqMZbYEfHe5RroJWWd5xvPwzjbGPrdNg5CCRX0KRvvyqII+9glJ279P6E4QKBgAqo\n+9V4uAT0ce/vBNsMFK3cvW6O/oj2NBZn00aSBptZWv8dURKwVJ8axFfQ8F5wWUwC\nHkuhZs6ZY9YdFgPW9qiwIozqjrcNQLot/m0hNUX2aC0QoayXTk7HiaAZIG2qPQuS\nIKcMD4ajnO6QXU14ugKZ1CrxFko4RS1hXb4Dj1t3AoGAGyf1WowDW3m61AgiyXyO\njPawo9X0vjXHz6kVVMekA+2oGywA7Id/+JOCPbQV7wC5ZEA9Kwzkro02KkusOo8b\nc/2xtLTWR4dduhUq9xPIK9Z1WaS4nLT8Rk2vFxazw3hOjeRcFw/ienftxyu5r2mr\nqn+WcyOatdYwfE657fesrQY=\n-----END PRIVATE KEY-----\n",
  "client_email": "personal-financial-app@financial-patner-app.iam.gserviceaccount.com",
  "client_id": "100289060927484208303",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/personal-financial-app%40financial-patner-app.iam.gserviceaccount.com"
  }''';

  //to set up connection
  static final _spreadsheetid = '1sdKesvSEX_sS5y7qQ3V48Wk0KUN1nc9ouJSkSifds5s';
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
