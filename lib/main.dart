import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacymanagement/add_expense/add_expense_page.dart';
import 'package:pharmacymanagement/add_sale/add_sale_page.dart';
import 'package:pharmacymanagement/add_stock/add_stock_page.dart';
import 'package:pharmacymanagement/expense_history/expense_history_page.dart';
import 'package:pharmacymanagement/login/login_page.dart';
import 'package:pharmacymanagement/sale_history/sale_history_page.dart';
import 'package:pharmacymanagement/stock_details/stock_details_page.dart';
import 'package:pharmacymanagement/utils/routes.dart';
import 'package:url_strategy/url_strategy.dart';

import 'dashboard/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAXGZocy2n3Unugri-Z3Yn9bR0UeCgY63U",
        authDomain: "pharmacymanagementsystem-77e40.firebaseapp.com",
        projectId: "pharmacymanagementsystem-77e40",
        storageBucket: "pharmacymanagementsystem-77e40.appspot.com",
        messagingSenderId: "779986993880",
        appId: "1:779986993880:web:176128de63794098818dad",
        measurementId: "G-6G60YQ8GY5"
    ),
  );
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacy Management System',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: MyRoutes.login,
      routes: {
        "/": (context) => HomePage(),
        MyRoutes.login: (context) => LoginPage(),
        MyRoutes.addStock: (context) => AddStockPage(),
        MyRoutes.stockDetails: (context) => StockDetailsPage(),
        MyRoutes.addSale: (context) => AddSalePage(),
        MyRoutes.saleHistory: (context) => SaleHistoryPage(),
        MyRoutes.addExpense: (context) => AddExpensePage(),
        MyRoutes.expenseHistory: (context) => ExpenseHistoryPage(),
      },
    );
  }
}
