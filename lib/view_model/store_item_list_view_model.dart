import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/models/store_item.dart';
import 'package:grocery_app/view_model/store_item_view_model.dart';
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

  void delete(StoreItemViewModel item) {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(storeViewModel.storeId)
        .collection('item')
        .doc(item.storeItem.storeId)
        .delete();
  }

  get storeItemsAsStream {
    Stream stream = FirebaseFirestore.instance
        .collection('stores')
        .doc(storeViewModel.storeId)
        .collection('item')
        .snapshots();
    return stream;
  }
}
