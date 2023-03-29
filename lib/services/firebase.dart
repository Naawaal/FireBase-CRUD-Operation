import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_crud/models/users_model.dart';
import 'package:flutter/material.dart';

class FirebaseClass {
  final firestore = FirebaseFirestore.instance;

  final time = DateTime.now().microsecondsSinceEpoch;

  //Todo: Add Users Data on FireStore
  Future addUserData(String name, String message, String number) async {
    final usermodel = UserModel(
      id: time.toString(),
      name: name,
      message: message,
      number: number,
    );
    await firestore
        .collection("users")
        .doc(time.toString())
        .set(usermodel.toJson());
  }

  //Todo: Get Users Data
  Stream<List<UserModel>> getUserData() {
    return firestore.collection('users').snapshots().map(
        (QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
                (doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  //Todo: Delete Users Data
  Future deleteUserData(String id) async {
    CollectionReference usersRef = firestore.collection('users');
    DocumentReference userDoc = usersRef.doc(id);
    await userDoc.delete().then((value) {
      debugPrint('Document deleted successfully!');
    }).catchError((error) {
      debugPrint('Failed to delete document: $error');
    });
  }

  //Todo: Update User Data
  Future updateUserDataWithDate(
      String id, String name, String message, String number) async {
    final userModel = UserModel(
      id: id,
      name: name,
      message: message,
      number: number,
    );
    firestore.collection("users").doc(id).update(userModel.toJson());
  }
}
