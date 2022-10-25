
import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  FieldValue? timeStamp;
  String? companyID;
  String? name;
  String? itemName;
  String? itemStatus;
  String? itemPrice;
  String? itemQuantity;
  String? docID;


  Company({
    this.timeStamp,
    this.companyID,
    this.name,
    this.itemName,
    this.itemStatus,
    this.itemPrice,
    this.itemQuantity,
    this.docID
  });


  factory Company.fromMap(map){
    return Company(
        timeStamp: map["timeStamp"],
        companyID: map["companyID"],
        name: map["name"],
      itemName: map["itemName"],
        itemStatus: map["itemStatus"],
        itemPrice: map["itemPrice"],
        itemQuantity: map["itemQuantity"],
        docID: map['docID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "timeStamp":timeStamp,
      "companyID":companyID,
      "name":name,
      "itemName":itemName,
      "itemStatus":itemStatus,
      "itemPrice":itemPrice,
      "itemQuantity": itemQuantity,
      'docID':docID
    };
  }
}
