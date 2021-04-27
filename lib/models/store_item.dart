import 'package:cloud_firestore/cloud_firestore.dart';

class StoreItem {
  String storeId;
  String name;
  double price;
  int quantity;

  StoreItem({this.price, this.quantity, this.name, this.storeId});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "price": price,
      "quantity": quantity,
    };
  }

  factory StoreItem.fromSnapshot(QueryDocumentSnapshot documentSnapshot) {
    print("called");
    return StoreItem(
      name: documentSnapshot['name'],
      quantity: documentSnapshot['quantity'],
      price: documentSnapshot['price'],
      storeId: documentSnapshot.id,
    );
  }
}
