import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacymanagement/add_stock/add_stock_desktop.dart';
import 'package:pharmacymanagement/add_stock/add_stock_mobile.dart';
import 'package:pharmacymanagement/all_company/all_company_desktop.dart';
import 'package:pharmacymanagement/company_details/company_details_desktop.dart';
import 'package:pharmacymanagement/dashboard/home_dasktop.dart';
import 'package:pharmacymanagement/dashboard/home_mobile.dart';
import 'package:pharmacymanagement/responsive/responsive_layout.dart';
import 'package:pharmacymanagement/stock_details/stock_details_desktop.dart';
import 'package:pharmacymanagement/stock_details/stock_details_mobile.dart';

class AllCompanyPage extends StatefulWidget {
  const AllCompanyPage({Key? key}) : super(key: key);

  @override
  State<AllCompanyPage> createState() => _AllCompanyPageState();
}

class _AllCompanyPageState extends State<AllCompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        desktopBody: AllCompanyDesktop(),
        mobileBody: StockDetailsMobile(),
      ),
    );
  }
}
