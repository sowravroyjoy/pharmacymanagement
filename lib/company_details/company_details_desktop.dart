import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pharmacymanagement/add_stock/add_stock_page.dart';
import 'package:pharmacymanagement/dashboard/home_page.dart';
import 'package:pharmacymanagement/utils/routes.dart';

import '../models/company.dart';
import '../models/product.dart';

class CompanyDetailsDesktop extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> company;
  const CompanyDetailsDesktop({Key? key, required this.company}) : super(key: key);

  @override
  State<CompanyDetailsDesktop> createState() => _CompanyDetailsDesktopState();
}

class _CompanyDetailsDesktopState extends State<CompanyDetailsDesktop> {
  int _totalProducts = 0;
  double _totalamount = 0.0;

  int totalLeads = 0;
  int index = 0;
  int restLeads = 0;
  int length = 10;
  final TextEditingController searchController = TextEditingController();

  List storedocs = [];
  bool search = false;


  final _formKey = GlobalKey<FormState>();
  final quantityEditingController = new TextEditingController();
  List<String> _productList = [];
  String? _chosenProduct;
  bool? _process;
  int? _count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _process = false;
    _count = 1;

    FirebaseFirestore.instance
        .collection('company')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["name"].toString().toLowerCase() == widget.company["name"].toString().toLowerCase() && doc["itemStatus"].toString().toLowerCase() != "created") {
          setState(() {
            _totalProducts = _totalProducts + 1;
            totalLeads += 1;
            restLeads += 1;
          });

          if (doc["itemStatus"].toString().toLowerCase() == "return" || doc["itemStatus"].toString().toLowerCase() == "given") {
            setState(() {
              // I will get
              _totalamount = _totalamount - (double.parse(doc["itemPrice"]) * double.parse(doc["itemQuantity"]));
            });
          }else {
              setState(() {
                // I will give
                _totalamount = _totalamount + (double.parse(doc["itemPrice"]) * double.parse(doc["itemQuantity"]));
              });
            }

        }
      }
    });

    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if(doc["company"] == widget.company["name"]){
          _productList.add(doc["name"]);
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    // final nameSearchField = Container(
    //     width: MediaQuery.of(context).size.width / 5,
    //     margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    //     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    //     decoration: BoxDecoration(
    //
    //         borderRadius: BorderRadius.circular(10)),
    //     child: TextFormField(
    //         cursorColor: Colors.black,
    //         autofocus: false,
    //         controller: searchController,
    //         keyboardType: TextInputType.name,
    //         validator: (value) {
    //           if (value!.isEmpty) {
    //             return ("name cannot be empty!!");
    //           }
    //           return null;
    //         },
    //         onSaved: (value) {
    //           searchController.text = value!;
    //         },
    //         onChanged: (value) {
    //           setState((){
    //             search = true;
    //             nameSearch(value);
    //           });
    //         },
    //         textInputAction: TextInputAction.next,
    //         decoration: InputDecoration(
    //           contentPadding: EdgeInsets.fromLTRB(
    //             20,
    //             15,
    //             20,
    //             15,
    //           ),
    //           labelText: 'Search Name',
    //           labelStyle: TextStyle(color: Colors.black),
    //           floatingLabelStyle: TextStyle(color: Colors.black),
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //           focusedBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //             borderSide: BorderSide(color: Colors.black),
    //           ),
    //         )));

    DropdownMenuItem<String> buildMenuProduct(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(color: Colors.blue),
        ));

    final productDropdown = Container(
        width: MediaQuery.of(context).size.width / 3,
        child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            items: _productList.map(buildMenuProduct).toList(),
            hint: Text(
              'Select Product',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.blue),
            ),
            value: _chosenProduct,
            onChanged: (newValue) {
              setState(() {
                _chosenProduct = newValue;
              });
            }));

    final quantityField = Container(
        width: MediaQuery.of(context).size.width / 3,
        child: TextFormField(
            cursorColor: Colors.blue,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
            autofocus: false,
            controller: quantityEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("quantity cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              quantityEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Quantity',
              labelStyle: TextStyle(color: Colors.blue),
              floatingLabelStyle: TextStyle(color: Colors.blue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue),
              ),
            )));

    final returnButton = Material(
      elevation: (_process!) ? 0 : 5,
      color: (_process!) ? Colors.blue.shade800 : Colors.blue,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(
          120,
          25,
          120,
          25,
        ),
        minWidth: 20,
        onPressed: () {
          setState(() {
            _process = true;
            _count = (_count! - 1);
          });
          (_count! < 0)
              ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text("Wait Please!!")))
              : returnProduct();
        },
        child: (_process!)
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Processing',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Center(
                child: SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ))),
          ],
        )
            : Text(
          'Return',
          textAlign: TextAlign.center,
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final returnWidget = Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10)
        ),
        child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      backgroundColor: Colors.blue.shade100,
                      title: Center(child: Text("Return Product")),
                      titleTextStyle: TextStyle(fontSize: 15),
                      scrollable: true,
                      content: SingleChildScrollView(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  productDropdown,
                                  SizedBox(height: 10,),
                                  quantityField,
                                  SizedBox(height: 20,),
                                  returnButton,
                                  SizedBox(height: 40,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            },
            child: Text(
              "Return Product",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            )
        )
    );


    final nextButton = ElevatedButton(
      onPressed: (){
        if(restLeads - 10 > 0){
          restLeads = restLeads - 10;
          setState((){
            index = index + 10;
          });
          if(restLeads < 10){
            setState((){
              length = length + restLeads;
            });
          }else{
            setState((){
              length = length + 10;
            });
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("No more entry!!")));
        }

      },
      child: Text(
        "NEXT",
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
    final prevButton = ElevatedButton(
      onPressed: (){

        if(restLeads + 10 <= totalLeads){
          restLeads = restLeads + 10;
          setState((){
            index = index - 10;
          });

          if(restLeads > 10){
            setState((){
              length = length - restLeads + 10;
              index = 0;
            });
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("No more entry!!")));
        }

      },
      child: Text(
        "PREV",
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );

    final CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection("company");

    Widget _buildListView() {
      if(search){
        restLeads = storedocs.length;
        index = 0;
        if(restLeads<10){
          length = restLeads;
        }else{
          length = 10;
        }
      }
      return FutureBuilder<QuerySnapshot>(
          future: _collectionReference.orderBy("timeStamp",  descending: true).get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went Wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text('Empty'),
              );
            } else {
              if (!search) {
                storedocs.clear();
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map a = document.data() as Map<String, dynamic>;
                  if (a['name'].toString().toLowerCase() == widget.company["name"].toString().toLowerCase() && a["itemStatus"].toString().toLowerCase() != "created"){
                    storedocs.add(a);
                    a['id'] = document.id;

                  }
                }).toList();
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Last updated',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Total Price',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Status',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),


                        for(var i = index; i<(storedocs.length < 11?storedocs.length:length); i++)...[
                          TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          (storedocs[i]["timeStamp"] != null)
                                              ? DateFormat('dd-MMM-yyyy').format(
                                              storedocs[i]["timeStamp"]
                                                  .toDate())
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.blue
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          storedocs[i]["itemName"],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.blue
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          storedocs[i]["itemQuantity"],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.blue
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          (double.parse(storedocs[i]["itemPrice"]) * double.parse(storedocs[i]["itemQuantity"])).toString(),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.blue
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          storedocs[i]["itemStatus"],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.blue
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:    IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context)=>AlertDialog(
                                                  title: Text("Confirm"),
                                                  content: Text("Do you want to delete it?"),
                                                  actions: [
                                                    IconButton(
                                                        icon: new Icon(Icons.close),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        }),
                                                    IconButton(
                                                        icon: new Icon(Icons.delete),
                                                        onPressed: () {
                                                          FirebaseFirestore.instance
                                                              .collection('company')
                                                              .get()
                                                              .then((QuerySnapshot querySnapshot) {
                                                            for (var doc in querySnapshot.docs) {
                                                              if(doc["docID"] == storedocs[i]["docID"]){
                                                                setState(() {
                                                                  doc.reference.delete();
                                                                  Navigator.pop(context);
                                                                });
                                                              }
                                                            }
                                                          });
                                                        })
                                                  ],
                                                )
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                        ]
                      ],
                    )
                ),
              );
            }
          });
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/deshboard.jpg"),
              fit: BoxFit.fill,
              opacity: 0.4),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue
                        ),
                        child: Text(
                          "Home",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue
                      ),
                      child: Text(
                        "Total types of medicine : $_totalProducts",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue
                      ),
                      child: Text(
                        "Company : ${widget.company["name"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue
                      ),
                      child: Text(
                        (_totalamount >= 0)? "I will give : $_totalamount": "I will get : ${_totalamount.abs()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // nameSearchField,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: prevButton,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: nextButton,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              _buildListView(),
              SizedBox(height: 10,),
              returnWidget,
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'developed by MEET-TECH LAB,  meettechlab@gmail.com,  +8801755460159',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              SizedBox(height: 40,),

            ],
          ),
        ),
      ),
    );
  }
  void returnProduct()  async{
    if (_formKey.currentState!.validate() && _chosenProduct != null) {

      FirebaseFirestore.instance
          .collection('products')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["name"].toString().toLowerCase() ==
              _chosenProduct.toString().toLowerCase() && doc["company"].toString().toLowerCase() ==
              widget.company["name"].toString().toLowerCase() ) {
            if (int.parse(doc["quantity"]) <
                int.parse(quantityEditingController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                      "Product in that quantity is not available!!")));
              setState(() {
                _process = false;
                _count = 1;
              });
            } else {
              var ref = FirebaseFirestore.instance.collection("products")
                  .doc(doc["docID"]);
              Product product = Product();
              product.timeStamp = FieldValue.serverTimestamp();
              product.productID = doc["productID"];
              product.name = doc["name"];
              product.quantity = (int.parse(doc["quantity"]) - int.parse(quantityEditingController.text)).toString();
              product.price = doc["price"];
              product.category = doc["category"];
              product.company = doc["company"];
              product.docID = doc["docID"];
              ref.set(product.toMap()).onError((error, stackTrace){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                        "Something is wrong!!")));
                setState(() {
                  _process = false;
                  _count = 1;
                });
              }).whenComplete((){
                var ref2 = FirebaseFirestore.instance.collection("company")
                    .doc();
                Company company = Company();
                company.timeStamp = FieldValue.serverTimestamp();
                company.companyID = "${widget.company["name"]}:2";
                company.name = widget.company["name"];
                company.itemName = _chosenProduct.toString();
                company.itemStatus = "Return";
                company.itemPrice = doc["price"];
                company.itemQuantity = quantityEditingController.text;
                company.docID = ref.id;
                ref2.set(company.toMap()).whenComplete(() {

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green, content: Text("Product Returned!!")));
                setState((){
                  _process = false;
                  _count = 1;
                  _chosenProduct = null;
                  quantityEditingController.clear();
                });
                Navigator.pop(context);
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          "Something is wrong!!")));
                  setState(() {
                    _process = false;
                    _count = 1;
                  });
                });
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                        "Something is wrong!!")));
                setState(() {
                  _process = false;
                  _count = 1;
                });
              });
            }
          }
        }
        });
    }
  }
  // void nameSearch(String value) async {
  //   final documents = await FirebaseFirestore.instance
  //       .collection('products')
  //       .orderBy("timeStamp", descending: true)
  //       .get();
  //   if (value != "") {
  //     storedocs.clear();
  //     for (var doc in documents.docs) {
  //       if (doc["name"]
  //           .toString()
  //           .toLowerCase()
  //           .contains(value.toLowerCase())) {
  //         storedocs.add(doc);
  //       }
  //     }
  //     setState(() {});
  //   } else {
  //     setState(() {
  //       storedocs.clear();
  //       search = false;
  //       restLeads = totalLeads;
  //       index = 0;
  //       if(restLeads<10){
  //         length = restLeads;
  //       }else{
  //         length = 10;
  //       }
  //     });
  //   }
  // }
}
