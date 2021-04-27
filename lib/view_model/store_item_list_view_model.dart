import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/models/store_item.dart';
import 'package:grocery_app/view_model/strore_view_model.dart';

class StoreItemListViewModel {
  String name;
  double price;
  int quantity;

  final StoreViewModel storeViewModel;
  StoreItemListViewModel({this.storeViewModel});

  void saveStoreItem() {
    final storeItem = StoreItem(name: name, quantity: quantity, price: price);
    FirebaseFirestore.instance
        .collection('stores')
        .doc(storeViewModel.storeId)
        .collection('item')
        .add(storeItem.toMap());
  }

  get storeItemsAsStream {
    Stream stream = FirebaseFirestore.instance
        .collection('stores')
        .doc(storeViewModel.storeId)
        .collection('item')
        .snapshots();

    print(stream);
    return stream;
  }
}
