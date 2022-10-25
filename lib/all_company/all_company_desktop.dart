import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pharmacymanagement/add_stock/add_stock_page.dart';
import 'package:pharmacymanagement/dashboard/home_page.dart';
import 'package:pharmacymanagement/utils/routes.dart';

import '../models/company.dart';

class AllCompanyDesktop extends StatefulWidget {
  const AllCompanyDesktop({Key? key}) : super(key: key);

  @override
  State<AllCompanyDesktop> createState() => _AllCompanyDesktopState();
}

class _AllCompanyDesktopState extends State<AllCompanyDesktop> {
  int _totalcompany = 0;

  int totalLeads = 0;
  int index = 0;
  int restLeads = 0;
  int length = 10;
  final TextEditingController searchController = TextEditingController();

  List storedocs = [];
  bool search = false;

  final _formKey2 = GlobalKey<FormState>();
  final companyEditingController = new TextEditingController();
  bool? _processC;
  int? _countC;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _processC = false;
    _countC = 1;

    FirebaseFirestore.instance
        .collection('company')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["companyID"].toString().split(":").last == "1"){
          setState(() {
            _totalcompany = _totalcompany + 1;
            totalLeads += 1;
            restLeads += 1;
          });
        }

        }

    });


  }

  @override
  Widget build(BuildContext context) {

    final companyField = Container(
        width: MediaQuery.of(context).size.width / 3,
        child: TextFormField(
            cursorColor: Colors.blue,
            autofocus: false,
            controller: companyEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if(value!.isEmpty){
                return ("company name cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              companyEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Company Name',
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

    final addCompanyButton = Material(
      elevation: (_processC!) ? 0 : 5,
      color: (_processC!) ? Colors.blue.shade800 : Colors.blue,
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
            _processC = true;
            _countC = (_countC! - 1);
          });
          (_countC! < 0)
              ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text("Wait Please!!")))
              : AddCompany();
        },
        child: (_processC!)
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
          'Add Company',
          textAlign: TextAlign.center,
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final _companyButton = Container(
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
                      title: Center(child: Text("New Company")),
                      titleTextStyle: TextStyle(fontSize: 15),
                      scrollable: true,
                      content: SingleChildScrollView(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _formKey2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  companyField,
                                  SizedBox(height: 20,),
                                  addCompanyButton,
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
              "New Company",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            )
        )
    );

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
    final prevButton =
    ElevatedButton(
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
                  if (a["companyID"].toString().split(":").last == "1") {
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
                                        'Company Name',
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
                                  child: InkWell(
                                    onTap: (){
                                      FirebaseFirestore.instance
                                          .collection('company')
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        for (var doc in querySnapshot.docs) {
                                          if(doc["name"].toString().toLowerCase() == storedocs[i]["name"].toString().toLowerCase()){
                                            Navigator.of(context).pushNamed(MyRoutes.companyDetails, arguments: doc);
                                          }
                                        }
                                      });

                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.medical_services_outlined, color: Colors.blue,),
                                            SizedBox(width: 10,),
                                            Text(
                                              storedocs[i]["name"],
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.blue
                                              ),
                                            ),
                                          ],
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
                        "Total number of companies : $_totalcompany",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    _companyButton
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

  void AddCompany()  async{
    bool _unique = true;
    if (_formKey2.currentState!.validate()) {

      FirebaseFirestore.instance
          .collection('company')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["name"].toString().toLowerCase() ==
              companyEditingController.text.toString().toLowerCase()) {
            _unique = false;
          }
        }

        if (_unique) {
          var ref = FirebaseFirestore.instance.collection("company")
              .doc();
          Company company = Company();
          company.timeStamp = FieldValue.serverTimestamp();
          company.companyID = "${companyEditingController.text}:1";
          company.name = companyEditingController.text;
          company.itemName = "Created";
          company.itemStatus = "Created";
          company.itemPrice = "0";
          company.itemQuantity = "0";
          company.docID = ref.id;
          ref.set(company.toMap()).whenComplete(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                    "New Company Added!!")));
            Navigator.pop(context);
            setState(() {
              _processC = false;
              _countC = 1;
              companyEditingController.clear();
            });
          }).onError((error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Something Wrong!!")));
            setState(() {
              _processC = false;
              _countC = 1;

            });
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  "Company is already exists!! Please add another company!!")));

          setState(() {
            _processC = false;
            _countC = 1;
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("Something Wrong!!")));
      setState(() {
        _processC = false;
        _countC = 1;
      });
    }
  }
  // void nameSearch(String value) async {
  //   final documents = await FirebaseFirestore.instance
  //       .collection('company')
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
