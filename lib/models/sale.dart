
import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  FieldValue? timeStamp;
  String? productID;
  String? name;
  String? quantity;
  String? price;
  String? category;
  String? buyerName;
  String? buyerContact;
  String? docID;


  Sale({
    this.timeStamp,
    this.productID,
    this.name,
    this.quantity,
    this.price,
    this.category,
    this.buyerName,
    this.buyerContact,
    this.docID
  });


  factory Sale.fromMap(map){
    return Sale(
        timeStamp: map["timeStamp"],
        productID: map["productID"],
        name: map['name'],
        quantity: map["quantity"],
        price: map["price"],
        category: map['category'],
        buyerName: map["buyerName"],
        buyerContact: map['buyerContact'],
        docID: map['docID']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "timeStamp":timeStamp,
      "productID":productID,
      'name': name,
      "quantity":quantity,
      "price":price,
      'category': category,
      "buyerName":buyerName,
      'buyerContact': buyerContact,
      'docID': docID
    };
  }
}
