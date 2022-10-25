import 'package:flutter/material.dart';

import '../utils/routes.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}


class _HomeDesktopState extends State<HomeDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/2,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/deshboard.jpg"),
                          fit: BoxFit.fill,
                          opacity: 0.6),
                    ),
                    child: Center(
                      child: Text(
                        'Welcome To Pharmacy Management System',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
            ),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getImageButton(() {Navigator.pushNamed(context, MyRoutes.addStock); }, 'assets/images/storage.jpg', "Add Stock"),
                      getImageButton(() { Navigator.pushNamed(context, MyRoutes.stockDetails);}, 'assets/images/storage.jpg', "Stock Details"),
                      getImageButton(() { Navigator.pushNamed(context, MyRoutes.addSale);}, 'assets/images/storage.jpg', "Add Sale"),
                      getImageButton(() {Navigator.pushNamed(context, MyRoutes.saleHistory); }, 'assets/images/storage.jpg', "Sale History")
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getImageButton(() {Navigator.pushNamed(context, MyRoutes.addExpense);}, 'assets/images/storage.jpg', "Add Expenses"),
                      getImageButton(() { Navigator.pushNamed(context, MyRoutes.expenseHistory);}, 'assets/images/storage.jpg', "Expense History"),
                      getImageButton(() { Navigator.pushNamed(context, MyRoutes.allCompany);}, 'assets/images/storage.jpg', "All Company"),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'developed by MEET-TECH LAB,  meettechlab@gmail.com,  +8801755460159',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
                width: MediaQuery.of(context).size.width / 5,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonText,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15,color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
}
