import 'package:flutter/material.dart';
import 'package:grocery_app/view_model/store_item_view_model.dart';

class StoreItemsWidget extends StatelessWidget {
  final List<StoreItemViewModel> storeItems;
  final Function(StoreItemViewModel) onStoreItemDeleted;
  StoreItemsWidget({this.storeItems, this.onStoreItemDeleted});

  Widget _buildItems(BuildContext context, int index) {
    return Dismissible(
      key: Key(storeItems[index].storeId),
      onDismissed: (_) {},
      background: Container(color: Colors.red),
      child: ListTile(title: Text(storeItems[index].name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: storeItems.length,
      itemBuilder: _buildItems,
    );
  }
}
