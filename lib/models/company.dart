
import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  FieldValue? timeStamp;
  String? name;
  String? docID;


  Company({
    this.timeStamp,
    this.name,
    this.docID
  });


  factory Company.fromMap(map){
    return Company(
        timeStamp: map["timeStamp"],
        name: map["name"],
        docID: map['docID']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "timeStamp":timeStamp,
      "name":name,
      'docID':docID
    };
  }
}
