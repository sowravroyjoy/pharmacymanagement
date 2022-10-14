import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacymanagement/utils/routes.dart';

import '../models/company.dart';
import '../models/product.dart';

class AddStockMobile extends StatefulWidget {
  const AddStockMobile({Key? key}) : super(key: key);

  @override
  State<AddStockMobile> createState() => _AddStockMobileState();
}

class _AddStockMobileState extends State<AddStockMobile> {
  final _formKey = GlobalKey<FormState>();
  final nameEditingController = new TextEditingController();
  final quantityEditingController = new TextEditingController();
  final priceEditingController = new TextEditingController();
  final categoryEditingController = new TextEditingController();

  List<String> _categoryList = ["none","new category"];
  String? _chosenCategory;

  List<String> _companyList = [];
  String? _chosenCompany;

  List<String> _productList = ["new product"];
  String? _chosenProduct;

  bool? _process;
  int? _count;
  bool _newCategory = false;
  bool _newProduct = false;
  String _selectedDoc = "";
  List<int> _indexList = [];

  final _formKey2 = GlobalKey<FormState>();
  final companyEditingController = new TextEditingController();
  bool? _processC;
  int? _countC;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _process = false;
    _count = 1;
    _processC = false;
    _countC = 1;
    FirebaseFirestore.instance
        .collection('company')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
       setState((){
          _companyList.add(doc["name"]);
       });
      }
    });

    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["category"] != "none") {
          setState(() {
            _categoryList.add(doc["category"]);
          });
        }
        setState(() {
          _productList.add(doc["name"]);
        });
      }
    }).whenComplete(() {
      for(int i=1; i < _categoryList.length;i++){
        if(_categoryList[i] ==_categoryList[i-1]){
          _indexList.add(i-1);
        }
      }
      for(int j in _indexList.reversed){
        setState((){
          _categoryList.removeAt(j);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nameField = Container(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextFormField(
            cursorColor: Colors.blue,
            autofocus: false,
            controller: nameEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if(_chosenProduct == "new product" && value!.isEmpty){
                return ("name cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              nameEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Name',
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

    final quantityField = Container(
        width: MediaQuery.of(context).size.width / 1.5,
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


    final priceField = Container(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextFormField(
            cursorColor: Colors.blue,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
            autofocus: false,
            controller: priceEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("price cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              priceEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Price',
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

    final categoryField = Container(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextFormField(
            cursorColor: Colors.blue,
            autofocus: false,
            controller: categoryEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if(_chosenCategory == "new category" && value!.isEmpty){
                return ("category cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              categoryEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Category',
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


    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(color: Colors.blue),
        ));

    final categoryDropdown = Container(
        width: MediaQuery.of(context).size.width / 1.5,
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
            items: _categoryList.map(buildMenuItem).toList(),
            hint: Text(
              'Select Category',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.blue),
            ),
            value: _chosenCategory,
            onChanged: (newValue) {
              setState(() {
                _chosenCategory = newValue;
                if(newValue == "new category"){
                  _newCategory = true;
                }else{
                  _newCategory = false;
                }
              });
            }));

    DropdownMenuItem<String> buildMenuCompany(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(color: Colors.blue),
        ));

    final companyDropdown = Container(
        width: MediaQuery.of(context).size.width / 1.5,
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
            items: _companyList.map(buildMenuCompany).toList(),
            hint: Text(
              'Select Company',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.blue),
            ),
            value: _chosenCompany,
            onChanged: (newValue) {
              setState(() {
                _chosenCompany = newValue;
              });
            }));


    DropdownMenuItem<String> buildMenuProduct(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(color: Colors.blue),
        ));

    final productDropdown = Container(
        width: MediaQuery.of(context).size.width / 1.5,
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
                if(newValue == "new product"){
                  _newProduct= true;
                  setState(() {
                    quantityEditingController.clear();
                    priceEditingController.clear();
                    _chosenCategory = null;
                    _selectedDoc = "";
                    _chosenCompany = null;
                  });
                }else{
                  _newProduct = false;
                  FirebaseFirestore.instance
                      .collection('products')
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    for (var doc in querySnapshot.docs) {
                      if(doc["name"].toString().toLowerCase() == newValue.toString().toLowerCase()){
                        setState(() {
                          quantityEditingController.text = doc["quantity"];
                          priceEditingController.text = doc["price"];
                          _chosenCategory = doc["category"];
                          _selectedDoc = doc["docID"];
                          _chosenCompany = doc["company"];
                        });
                      }
                    }
                  });
                }
              });
            }));


    final addButton = Material(
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
              : AddData();
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
            : (_selectedDoc !="")?Text(
          'Update Product',
          textAlign: TextAlign.center,
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ):Text(
          'Add Product',
          textAlign: TextAlign.center,
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection("company");

    Widget _buildListView() {
      return StreamBuilder<QuerySnapshot>(
          stream: _collectionReference.orderBy("timeStamp",  descending: true).snapshots().asBroadcastStream(),
          builder: (context, snapshot) {
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

              final List storedocs = [];
              snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                storedocs.add(a);
                a['id'] = document.id;
              }).toList();


              return  Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
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
                                  color: Colors.blue.shade300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.blue.shade300,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),


                        for(var i = 0 ; i< storedocs.length; i++)...[
                          TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          storedocs[i]["name"],
                                          style: TextStyle(
                                            fontSize: 10.0,
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
                                            FirebaseFirestore.instance
                                                .collection('company')
                                                .get()
                                                .then((QuerySnapshot querySnapshot) {
                                              for (var doc in querySnapshot.docs) {
                                                if(doc["docID"] == storedocs[i]["docID"]){
                                                  setState(() {
                                                    doc.reference.delete();
                                                  });
                                                }
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 15,
                                            color: Colors.black,
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

    final companyField = Container(
        width: MediaQuery.of(context).size.width / 1.5,
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
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(
          40,
          10,
          40,
          10,
        ),
        minWidth: 10,
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
                                  SizedBox(height: 10,),
                                  addCompanyButton,
                                  SizedBox(height: 20,),
                                  _buildListView(),
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
              "Company",
              style: TextStyle(
                  color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            )
        )
    );






    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/deshboard.jpg"),
                  fit: BoxFit.fill,
                  opacity: 0.4),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _newProduct? nameField:Text(""),
                  SizedBox(height: 10,),
                  productDropdown,
                  SizedBox(height: 10,),
                  quantityField,
                  SizedBox(height: 10,),
                  priceField,
                  SizedBox(height: 10,),
                  companyDropdown,
                  SizedBox(height: 10,),
                  categoryDropdown,
                  SizedBox(height: 10,),
                  _newCategory? categoryField:Text(""),
                  SizedBox(height: 10,),
                  addButton,
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, MyRoutes.stockDetails);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue
                          ),
                          child: Text(
                            "Stock Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      _companyButton
                    ],
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'developed by MEET-TECH LAB,  meettechlab@gmail.com,  +8801755460159',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  void AddData()  async{
    int _productID = 1;
    bool _unique = true;
    if (_formKey.currentState!.validate() &&
        _chosenCategory != null && _chosenProduct != null) {

      FirebaseFirestore.instance
          .collection('products')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if(doc["productID"].toString().toLowerCase() == "${_chosenCategory.toString().toLowerCase()}:1"  ||  doc["productID"].toString().toLowerCase() == "${categoryEditingController.text.toString().toLowerCase()}:1" ){
            if(int.parse(doc["productID"].toString().split(":").last) <= _productID){
              _productID = _productID + 1;
            }
          }
        }

        FirebaseFirestore.instance
            .collection('products')
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            if (doc["name"].toString().toLowerCase() ==
                nameEditingController.text.toString().toLowerCase()) {
              _unique = false;
            }
          }

          if (_unique) {
            var ref = FirebaseFirestore.instance.collection("products")
                .doc();

            if(_selectedDoc != ""){
              ref = FirebaseFirestore.instance.collection("products")
                  .doc(_selectedDoc);
            }

            Product product = Product();
            product.timeStamp = FieldValue.serverTimestamp();
            (_chosenCategory != "new category")
                ? product.productID =
                _chosenCategory.toString() + ":" + _productID.toString()
                : product.productID =
                categoryEditingController.text.toString().toLowerCase() +
                    ":" + _productID.toString();
            (_chosenProduct != "new product") ?
            product.name = _chosenProduct.toString() : product.name =
                nameEditingController.text;
            product.quantity = quantityEditingController.text;
            product.price = priceEditingController.text;
            (_chosenCategory != "new category") ?
            product.category = _chosenCategory.toString() : product.category =
                categoryEditingController.text.toString().toLowerCase();
            product.company = _chosenCompany;
            product.docID = ref.id;
            ref.set(product.toMap()).whenComplete(() {
              (_selectedDoc != "")?ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                      "Product Updated!!"))):ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                      "New Product Added!!")));
              setState(() {
                _process = false;
                _count = 1;
                nameEditingController.clear();
                quantityEditingController.clear();
                priceEditingController.clear();
                categoryEditingController.clear();
                _chosenCategory = null;
                _chosenProduct = null;
                _newCategory = false;
                _newProduct = false;
                _chosenCompany = null;
              });

              FirebaseFirestore.instance
                  .collection('products')
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                setState(() {
                  _categoryList.clear();
                  _categoryList.add("none");
                  _categoryList.add("new category");
                  _productList.clear();
                  _productList.add("new product");
                });
                for (var doc in querySnapshot.docs) {
                  if (doc["productID"].toString().split(":").last == "1"&& doc["productID"].toString().split(":").first != "none") {
                    setState(() {
                      _categoryList.add(doc["category"]);
                    });
                  }
                  setState(() {
                    _productList.add(doc["name"]);
                  });
                }
              });
            }).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Something Wrong!!")));
              setState(() {
                _process = false;
                _count = 1;

              });
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                    "Already a product available in this name. Please select that product and update the quantity!!")));
            setState(() {
              _process = false;
              _count = 1;
            });
          }
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("Something Wrong!!")));
      setState(() {
        _process = false;
        _count = 1;
      });
    }
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
            var temp = companyEditingController.text;
            Company company = Company();
            company.timeStamp = FieldValue.serverTimestamp();
            company.name = companyEditingController.text;
            company.docID = ref.id;
            ref.set(company.toMap()).whenComplete(() {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                      "New Company Added!!")));
              setState(() {
                _processC = false;
                _countC = 1;
                companyEditingController.clear();
                _companyList.add(temp);
              });
            }).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Something Wrong!!")));
              setState(() {
                _process = false;
                _count = 1;

              });
            });
          } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
          "Company is already exists!! Please add another company!!")));

            setState(() {
              _process = false;
              _count = 1;
            });
          }
        });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("Something Wrong!!")));
      setState(() {
        _process = false;
        _count = 1;
      });
    }
  }
}
