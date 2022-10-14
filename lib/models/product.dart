
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  FieldValue? timeStamp;
  String? productID;
  String? name;
  String? quantity;
  String? price;
  String? category;
  String? company;
  String? docID;


  Product({
    this.timeStamp,
    this.productID,
    this.name,
    this.quantity,
    this.price,
    this.category,
    this.company,
    this.docID
  });


  factory Product.fromMap(map){
    return Product(
        timeStamp: map["timeStamp"],
        productID: map["productID"],
        name: map['name'],
        quantity: map["quantity"],
        price: map["price"],
        category: map['category'],
        company: map['company'],
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
      'company': company,
      'docID': docID
    };
  }
}
