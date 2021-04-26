import 'package:cloud_firestore/cloud_firestore.dart';

class StoreListViewModel {
  Stream<QuerySnapshot> get storeAsStream =>
      FirebaseFirestore.instance.collection('stores').snapshots();
}
