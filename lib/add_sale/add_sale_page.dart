import 'package:flutter/material.dart';
import 'package:pharmacymanagement/add_sale/add_sale_desktop.dart';
import 'package:pharmacymanagement/add_sale/add_sale_mobile.dart';
import 'package:pharmacymanagement/add_stock/add_stock_desktop.dart';
import 'package:pharmacymanagement/add_stock/add_stock_mobile.dart';
import 'package:pharmacymanagement/dashboard/home_dasktop.dart';
import 'package:pharmacymanagement/dashboard/home_mobile.dart';
import 'package:pharmacymanagement/responsive/responsive_layout.dart';
import 'package:pharmacymanagement/stock_details/stock_details_desktop.dart';
import 'package:pharmacymanagement/stock_details/stock_details_mobile.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({Key? key}) : super(key: key);

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        desktopBody: AddSaleDesktop(),
        mobileBody: AddSaleMobile(),
      ),
    );
  }
}
