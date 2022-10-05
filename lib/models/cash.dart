
import 'package:cloud_firestore/cloud_firestore.dart';

class Cash {
  FieldValue? timeStamp;
  String? reasonType;
  String? reason;
  String? amount;
  String? docID;


  Cash({
    this.timeStamp,
    this.reasonType,
    this.reason,
    this.amount,
    this.docID
  });


  factory Cash.fromMap(map){
    return Cash(
        timeStamp: map["timeStamp"],
        reasonType: map["reasonType"],
        reason: map["reason"],
        amount: map['amount'],
        docID: map['docID']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "timeStamp":timeStamp,
      "reasonType":reasonType,
      "reason":reason,
      'amount': amount,
      'docID': docID
    };
  }
}
