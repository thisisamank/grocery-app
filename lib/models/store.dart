import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final name;
  final address;
  final DocumentReference documentReference;
  Store(this.name, this.address, [this.documentReference]);
  String get storeId => documentReference.id;

  Map<String, dynamic> get toMap => {"name": name, "address": address};

  factory Store.fromQuerySnapshot(QueryDocumentSnapshot snapshot) {
    return Store(snapshot["name"], snapshot["address"], snapshot.reference);
  }
}
