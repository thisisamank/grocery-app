import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/pages/add_store_page.dart';
import 'package:grocery_app/pages/store_item_list_page.dart';
import 'package:grocery_app/view_model/add_store_view_model.dart';
import 'package:grocery_app/view_model/store_list_view_model.dart';
import 'package:grocery_app/view_model/strore_view_model.dart';
import 'package:grocery_app/widgets/empty_results_widget.dart';
import 'package:provider/provider.dart';

class StoreListPage extends StatefulWidget {
  @override
  _StoreListPage createState() => _StoreListPage();
}

class _StoreListPage extends State<StoreListPage> {
  StoreListViewModel storeListViewModel = StoreListViewModel();
  Widget _buildBody() {
    return StreamBuilder(
        stream: storeListViewModel.storeAsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
            return _buildList(snapshot.data);
          }
          return EmptyResultsWidget(message: "No Stores found");
        });
  }

  _buildList(QuerySnapshot snapshot) {
    final stores =
        snapshot.docs.map((data) => StoreViewModel.fromSnapshot(data)).toList();
    return ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return _buildListItem(store, (store) {
            _navigateToStorePage(store, context);
          });
        });
  }

  _navigateToStorePage(StoreViewModel store, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StoreItemListPage(store: store)),
    );
  }

  _buildListItem(
    StoreViewModel storeViewModel,
    void Function(StoreViewModel) onStoreSelected,
  ) {
    return ListTile(
      title: Text(storeViewModel.name),
      subtitle: Text(storeViewModel.address),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => onStoreSelected(storeViewModel),
    );
  }

  _navigateToAddStorePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => AddStoreViewModel(),
          child: AddStorePage(),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Grocery App"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Icon(Icons.add),
                onTap: () {
                  _navigateToAddStorePage(context);
                },
              ),
            )
          ],
        ),
        body: _buildBody());
  }
}
