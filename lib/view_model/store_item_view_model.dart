import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/store_item.dart';

class StoreItemViewModel {
  final StoreItem storeItem;
  final Function(StoreItemViewModel) onStoreItemDeleted;
  StoreItemViewModel({this.storeItem, this.onStoreItemDeleted});
  get name => storeItem.name;
  get storeId => storeItem.storeId;

  factory StoreItemViewModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    final storeItem = StoreItem.fromSnapshot(snapshot);
    return StoreItemViewModel(storeItem: storeItem);
  }
}
