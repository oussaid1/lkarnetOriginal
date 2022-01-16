import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  String? name;
  String? email;

  UserModel({this.id, this.name, this.email});
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
    };
  }

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
  }
  UserModel.fromUserCredential(UserCredential userCredential, String username)
      : id = userCredential.user!.uid,
        name = username,
        email = userCredential.user!.email;
}
