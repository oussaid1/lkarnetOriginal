import 'dart:convert';

import 'package:lkarnet/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  // final gooleSignIn = GoogleSignIn();
  AuthenticationService(this._firebaseAuth);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

// many unhandled google error exist
// will push them soon
  // Future<bool> googleSignIn() async {
  //   GoogleSignInAccount? googleSignInAccount = await gooleSignIn.signIn();

  //   if (googleSignInAccount != null) {
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;

  //     OAuthCredential credential = GoogleAuthProvider.credential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken);

  //     //User? user = _firebaseAuth.currentUser;
  //     Map<String, dynamic> idMap =
  //         parseJwt(googleSignInAuthentication.idToken)!;
  //     final String firstName = idMap["given_name"];
  //     // final String lastName = idMap["family_name"];

  //     await _firebaseAuth.signInWithCredential(credential).then((value) =>
  //         createNewUser(UserModel.fromUserCredential(value, firstName)));
  //     return Future.value(true);
  //   } else
  //     return Future.value(false);
  // }

  static Map<String, dynamic>? parseJwt(String? token) {
    // validate token
    if (token == null) return null;
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    // retrieve token payload
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    // convert to Map
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Successfully signed in';
    } on FirebaseAuthException catch (e) {
      return '$e';
    }
  }

  Future<String?> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) =>
              createNewUser(UserModel.fromUserCredential(value.user!)));
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return 'failed $e';
    }
  }

  Future<bool> signout() async {
    await _firebaseAuth.signOut();
    // User? user = _firebaseAuth.currentUser;

    // if (user!.providerData[1].providerId == 'google.com') {
    //   await gooleSignIn.signOut().then(
    //       (value) => value == null ? Future.value(true) : Future.value(false));
    // }
    // return await _firebaseAuth.signOut().then(
    //       (value) => Future.value(true),
    //     );
    return Future.value(true);
  }

  Future<bool> createNewUser(UserModel user) async {
    bool _done = false;
    await users
        .doc(user.id)
        .set(user.toMap())
        .then((value) => _done = true)
        .catchError((error) {
      _done = false;
      print("Failed to add user: $error");
      return false;
    });
    return _done;
  }

  Future<UserModel> getUser(String uid) async {
    return await users
        .doc(uid)
        .get()
        .then(
            (value) => UserModel.fromDocumentSnapshot(documentSnapshot: value))
        // ignore: return_of_invalid_type_from_catch_error
        .catchError((e) => print(e));
  }

  static Future<void> pop() async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', true);
  }

  Future resetPass(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {}
  }
}
