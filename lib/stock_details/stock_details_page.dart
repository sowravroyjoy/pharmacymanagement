import 'package:flutter/material.dart';
import 'package:pharmacymanagement/add_stock/add_stock_desktop.dart';
import 'package:pharmacymanagement/add_stock/add_stock_mobile.dart';
import 'package:pharmacymanagement/dashboard/home_dasktop.dart';
import 'package:pharmacymanagement/dashboard/home_mobile.dart';
import 'package:pharmacymanagement/responsive/responsive_layout.dart';
import 'package:pharmacymanagement/stock_details/stock_details_desktop.dart';
import 'package:pharmacymanagement/stock_details/stock_details_mobile.dart';

class StockDetailsPage extends StatefulWidget {
  const StockDetailsPage({Key? key}) : super(key: key);

  @override
  State<StockDetailsPage> createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        desktopBody: StockDetailsDesktop(),
        mobileBody: StockDetailsMobile(),
      ),
    );
  }
}
