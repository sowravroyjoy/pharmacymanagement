import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pharmacymanagement/add_stock/add_stock_page.dart';
import 'package:pharmacymanagement/dashboard/home_page.dart';
import 'package:pharmacymanagement/utils/routes.dart';

class SaleHistoryDesktop extends StatefulWidget {
  const SaleHistoryDesktop({Key? key}) : super(key: key);

  @override
  State<SaleHistoryDesktop> createState() => _SaleHistoryDesktopState();
}

class _SaleHistoryDesktopState extends State<SaleHistoryDesktop> {

  int totalLeads = 0;
  int index = 0;
  int restLeads = 0;
  int length = 10;
  final TextEditingController searchController = TextEditingController();

  List storedocs = [];
  bool search = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection('sales')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          totalLeads += 1;
          restLeads +=1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final nameSearchField = Container(
        width: MediaQuery.of(context).size.width / 4,
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            cursorColor: Colors.black,
            autofocus: false,
            controller: searchController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("buyer name cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              searchController.text = value!;
            },
            onChanged: (value) {
              setState((){
                search = true;
                nameSearch(value);
              });
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Search Buyer',
              labelStyle: TextStyle(color: Colors.black),
              floatingLabelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black),
              ),
            )));


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
    FirebaseFirestore.instance.collection("sales");

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
                  storedocs.add(a);
                  a['id'] = document.id;
                }).toList();
              }
              return  Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Date',
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
                                        'Product',
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Price',
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
                                        'Buyer Name',
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
                                        'Buyer Contact',
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
                                          storedocs[i]["name"],
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
                                          storedocs[i]["quantity"],
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
                                          storedocs[i]["price"],
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
                                          storedocs[i]["buyerName"],
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
                                          storedocs[i]["buyerContact"],
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
                                                              .collection('sales')
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
                          "Back to home",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, MyRoutes.addSale);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue
                        ),
                        child: Text(
                          "Add Sale",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
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
                    nameSearchField,
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
  void nameSearch(String value) async {
    final documents = await FirebaseFirestore.instance
        .collection('sales')
        .orderBy("timeStamp", descending: true)
        .get();
    if (value != "") {
      storedocs.clear();
      for (var doc in documents.docs) {
        if (doc["buyerName"]
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase())) {
          storedocs.add(doc);
        }
      }
      setState(() {});
    } else {
      setState(() {
        storedocs.clear();
        search = false;
        restLeads = totalLeads;
        index = 0;
        if(restLeads<10){
          length = restLeads;
        }else{
          length = 10;
        }
      });
    }
  }
}
