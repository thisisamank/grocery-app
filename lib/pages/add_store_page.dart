import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/view_model/add_store_view_model.dart';
import 'package:provider/provider.dart';

class AddStorePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  AddStoreViewModel _addStoreViewModel;
  _saveDataToFirebase(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      var isSaved = await _addStoreViewModel.saveStore();
      if (isSaved) {
        //Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _addStoreViewModel = Provider.of<AddStoreViewModel>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Add Store")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => _addStoreViewModel.storeName = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter store name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter store name"),
                ),
                TextFormField(
                  onChanged: (value) => _addStoreViewModel.address = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter store address";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter store address"),
                ),
                ElevatedButton(
                  child: Text("Save", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _saveDataToFirebase(context);
                  },
                ),
                Spacer(),
                Text(_addStoreViewModel.message)
              ],
            ),
          ),
        ));
  }
}
