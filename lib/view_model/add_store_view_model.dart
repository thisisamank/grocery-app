import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/store.dart';

class AddStoreViewModel extends ChangeNotifier {
  var storeName = "";
  var address = "";
  var isSaved = false;
  var message = "";
  Future<bool> saveStore() async {
    Store store = new Store(storeName, address);
    try {
      await FirebaseFirestore.instance.collection('stores').add(store.toMap);
      message = "store has been saved";
      isSaved = true;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      isSaved = false;
    }
    notifyListeners();
    return isSaved;
  }
}
