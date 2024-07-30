import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_comment/features/home/data/models/data_model.dart';
import 'package:http/http.dart' as http;

abstract interface class FetchDataDatasources {
  Future<List<DataModel>> fetchData();

  Future<void> signOut();
}

class FetchDataDatasourcesImp implements FetchDataDatasources {
  final FirebaseAuth _firebaseAuth;

  FetchDataDatasourcesImp({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  Future<List<DataModel>> fetchData() async {
    try {
      //replace your restFull API here.
      String url = "https://jsonplaceholder.typicode.com/comments";
      final response = await http.get(Uri.parse(url));

      var responseData = json.decode(response.body);

      //Creating a list to store input data;
      List<DataModel> users = [];
      for (var singleUser in responseData) {
        DataModel user = DataModel.fromMap(singleUser);

        //Adding user to the list.
        users.add(user);
      }
      return users;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
