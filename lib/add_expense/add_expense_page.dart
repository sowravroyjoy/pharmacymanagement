import 'package:flutter/material.dart';
import 'package:pharmacymanagement/add_expense/add_expense_desktop.dart';
import 'package:pharmacymanagement/add_expense/add_expense_mobile.dart';
import 'package:pharmacymanagement/add_sale/add_sale_desktop.dart';
import 'package:pharmacymanagement/add_sale/add_sale_mobile.dart';
import 'package:pharmacymanagement/add_stock/add_stock_desktop.dart';
import 'package:pharmacymanagement/add_stock/add_stock_mobile.dart';
import 'package:pharmacymanagement/dashboard/home_dasktop.dart';
import 'package:pharmacymanagement/dashboard/home_mobile.dart';
import 'package:pharmacymanagement/responsive/responsive_layout.dart';
import 'package:pharmacymanagement/stock_details/stock_details_desktop.dart';
import 'package:pharmacymanagement/stock_details/stock_details_mobile.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        desktopBody: AddExpenseDesktop(),
        mobileBody: AddExpenseMobile(),
      ),
    );
  }
}
