import 'package:flutter/material.dart';
import 'package:pharmacymanagement/add_stock/add_stock_desktop.dart';
import 'package:pharmacymanagement/add_stock/add_stock_mobile.dart';
import 'package:pharmacymanagement/dashboard/home_dasktop.dart';
import 'package:pharmacymanagement/dashboard/home_mobile.dart';
import 'package:pharmacymanagement/expense_history/expense_history_desktop.dart';
import 'package:pharmacymanagement/expense_history/expense_history_mobile.dart';
import 'package:pharmacymanagement/responsive/responsive_layout.dart';
import 'package:pharmacymanagement/sale_history/sale_history_desktop.dart';
import 'package:pharmacymanagement/sale_history/sale_history_mobile.dart';
import 'package:pharmacymanagement/stock_details/stock_details_desktop.dart';
import 'package:pharmacymanagement/stock_details/stock_details_mobile.dart';

class ExpenseHistoryPage extends StatefulWidget {
  const ExpenseHistoryPage({Key? key}) : super(key: key);

  @override
  State<ExpenseHistoryPage> createState() => _ExpenseHistoryPageState();
}

class _ExpenseHistoryPageState extends State<ExpenseHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        desktopBody: ExpenseHistoryDesktop(),
        mobileBody: ExpenseHistoryMobile(),
      ),
    );
  }
}
