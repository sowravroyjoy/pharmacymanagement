import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/cash.dart';
import '../utils/routes.dart';

class AddExpenseMobile extends StatefulWidget {
  const AddExpenseMobile({Key? key}) : super(key: key);

  @override
  State<AddExpenseMobile> createState() => _AddExpenseMobileState();
}

class _AddExpenseMobileState extends State<AddExpenseMobile> {
  final _formKey = GlobalKey<FormState>();
  final cashEditingController = new TextEditingController();
  var reasonEditingController;


  bool? _process;
  int? _count;

  int _totalAmount = 0;

  List<String> _cashList = ["Deposit", "Withdraw"];
  String? _chosenCash;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _process = false;
    _count = 1;

    reasonEditingController = new TextEditingController();

    FirebaseFirestore.instance
        .collection('sales')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _totalAmount = _totalAmount + int.parse(doc["price"]);
        });
      }
    });

    FirebaseFirestore.instance
        .collection('cash')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if(doc["reasonType"] == "Deposit"){
          setState(() {
            _totalAmount = _totalAmount + int.parse(doc["amount"]);
          });
        }else{
          setState(() {
            _totalAmount = _totalAmount - int.parse(doc["amount"]);
          });
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    DropdownMenuItem<String> buildMenuCash(String item) =>
        DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: TextStyle(color: Colors.blue),
            ));

    final cashDropdown = Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
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
            items: _cashList.map(buildMenuCash).toList(),
            hint: Text(
              'Select Deposit/Withdraw',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.blue),
            ),
            value: _chosenCash,
            onChanged: (newValue) {
              setState(() {
                _chosenCash = newValue;
              });
            }));



    final cashField = Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
        child: TextFormField(
            cursorColor: Colors.blue,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
            ],
            autofocus: false,
            controller: cashEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("amount cannot be empty!!");
              }
              return null;
            },
            onSaved: (value) {
              cashEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Amount',
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

    final reasonField = Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
        child: TextFormField(
            cursorColor: Colors.blue,
            autofocus: false,
            controller: reasonEditingController,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              reasonEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                20,
                15,
                20,
                15,
              ),
              labelText: 'Reason',
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



    final addButton = Material(
      elevation: (_process!) ? 0 : 5,
      color: (_process!) ? Colors.blue.shade800 : Colors.blue,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(
          100,
          20,
          100,
          20,
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
              'Wait',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Center(
                child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ))),
          ],
        )
            : Text(
          '  Add Entry  ',
          textAlign: TextAlign.center,
          style:
          TextStyle(color: Colors.white),
        ),
      ),
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
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue
                    ),
                    child: Text(
                      "Total Amount : $_totalAmount TK",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  cashDropdown,
                  SizedBox(height: 10,),
                  reasonField,
                  SizedBox(height: 10,),
                  cashField,
                  SizedBox(height: 30,),
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
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, MyRoutes.expenseHistory);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue
                          ),
                          child: Text(
                            "Expense History",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void AddData() async {
    if (_formKey.currentState!.validate() && _chosenCash != null) {
      var ref = FirebaseFirestore.instance.collection("cash")
          .doc();
      Cash cash = Cash();
      cash.timeStamp = FieldValue.serverTimestamp();
      cash.reasonType = _chosenCash;
      cash.reason = reasonEditingController.text;
      cash.amount = cashEditingController.text;
      cash.docID = ref.id;
      ref.set(cash.toMap()).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
                "Entry Successful!!")));
        setState(() {
          _process = false;
          _count = 1;
          if(_chosenCash == "Deposit"){
            _totalAmount = _totalAmount + int.parse(cashEditingController.text);
            cashEditingController.clear();
            reasonEditingController.clear();
            _chosenCash = null;
          }else{
            _totalAmount = _totalAmount - int.parse(cashEditingController.text);
            cashEditingController.clear();
            reasonEditingController.clear();
            _chosenCash = null;
          }
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
