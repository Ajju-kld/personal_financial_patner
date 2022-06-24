import 'package:flutter/material.dart';
import 'package:personal_financial_patner/google_sheets_api.dart';
import 'Homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: Homescreen(),
    );
  }
}
