import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/view_model/store_item_list_view_model.dart';
import 'package:grocery_app/view_model/store_item_view_model.dart';
import 'package:grocery_app/view_model/strore_view_model.dart';
import 'package:grocery_app/widgets/store_items_widget.dart';

class StoreItemListPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  final StoreViewModel store;
  StoreItemListViewModel _storeItemListViewModel;
  StoreItemListPage({this.store})
      : _storeItemListViewModel =
            new StoreItemListViewModel(storeViewModel: store);

  final _formKey = GlobalKey<FormState>();

  String _validate(String value) {
    if (value.isEmpty) {
      return "Field cannot be empty";
    }

    return null;
  }

  void _saveStoreItem() {
    if (_formKey.currentState.validate()) {
      _storeItemListViewModel.name = _nameController.text;
      _storeItemListViewModel.price = double.parse(_priceController.text);
      _storeItemListViewModel.quantity = int.parse(_quantityController.text);

      _storeItemListViewModel.saveStoreItem();
      _clearTextBoxes();
    }
  }

  void _clearTextBoxes() {
    _nameController.clear();
    _priceController.clear();
    _quantityController.clear();
  }

  Widget _buildStoreItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: _storeItemListViewModel.storeItemsAsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<StoreItemViewModel> storeItems = snapshot.data.docs
              .map((item) => StoreItemViewModel.fromSnapshot(item))
              .toList();
          print(' data : ${snapshot.data}');
          print(snapshot.data.docs);
          return StoreItemsWidget(storeItems: storeItems);
        }
        return Text("No Data found!");
      },
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: _nameController,
            validator: _validate,
            decoration: InputDecoration(hintText: "Enter store item"),
          ),
          TextFormField(
            controller: _priceController,
            validator: _validate,
            decoration: InputDecoration(hintText: "Enter price"),
          ),
          TextFormField(
            controller: _quantityController,
            validator: _validate,
            decoration: InputDecoration(hintText: "Enter quantity"),
          ),
          RaisedButton(
            child: Text("Save", style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            onPressed: () {
              _saveStoreItem();
            },
          ),
          Expanded(child: _buildStoreItems())
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(store.name),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )),
        body: _buildBody());
  }
}
