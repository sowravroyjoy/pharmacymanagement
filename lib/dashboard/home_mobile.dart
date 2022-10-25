import 'package:flutter/material.dart';

import '../utils/routes.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome To Pharmacy Management System'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                getImageButton(() {Navigator.pushNamed(context, MyRoutes.addStock);}, 'assets/images/storage.jpg', "Add Stock"),
                SizedBox(
                  height: 20,
                ),
                getImageButton(
                    () {Navigator.pushNamed(context, MyRoutes.stockDetails);}, 'assets/images/storage.jpg', "Stock Details"),
                SizedBox(
                  height: 20,
                ),
                getImageButton(() {Navigator.pushNamed(context, MyRoutes.addSale);}, 'assets/images/storage.jpg', "Add Sale"),
                SizedBox(
                  height: 20,
                ),
                getImageButton(
                    () {Navigator.pushNamed(context, MyRoutes.saleHistory);}, 'assets/images/storage.jpg', "Sale History"),
                SizedBox(
                  height: 20,
                ),
                getImageButton(
                    () {Navigator.pushNamed(context, MyRoutes.addExpense);}, 'assets/images/storage.jpg', "Add Expenses"),
                SizedBox(
                  height: 20,
                ),
                getImageButton(
                    () {Navigator.pushNamed(context, MyRoutes.expenseHistory);}, 'assets/images/storage.jpg', "Expense History"),
                SizedBox(
                  height: 20,
                ),
                getImageButton(() { Navigator.pushNamed(context, MyRoutes.allCompany);}, 'assets/images/storage.jpg', "All Company"),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'developed by MEET-TECH LAB',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(height: 10,),
                Text(
                  'meettechlab@gmail.com,  +8801755460159',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getImageButton(VoidCallback action, String url, String buttonText) =>
      Material(
        color: Colors.blue,
        elevation: 2,
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.black26,
          onTap: action,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Ink.image(
                image: AssetImage(
                  url,
                ),
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonText,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 15,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
}
