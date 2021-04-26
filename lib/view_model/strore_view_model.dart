import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/store.dart';

class StoreViewModel {
  final Store store;
  StoreViewModel(this.store);
  String get name => store.name;
  String get address => store.address;
  String get storeId => store.storeId;

  factory StoreViewModel.fromSnapshot(QueryDocumentSnapshot documentSnapshot) {
    final store = Store.fromQuerySnapshot(documentSnapshot);
    return StoreViewModel(store);
  }
}
