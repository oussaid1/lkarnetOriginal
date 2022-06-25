import 'package:lkarnet/database/database.dart';
import 'package:lkarnet/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_providers.dart';

final userModelProvider = FutureProvider<UserModel>((ref) async {
  final db = ref.watch(databaseProvider);
  var _user = await db.getUser();
  return _user ?? UserModel.empty();
});

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// 2
final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

// 3
final databaseProvider = Provider<Database>((ref) {
  final uid = ref.watch(uidProvider);
  return Database(uid: uid);
});

final uidProvider = Provider<String>((ref) {
  final auth = ref.watch(authStateProvider);
  String uid = '';
  auth.whenData((value) => uid = value!.uid);

  return uid;
});

class DbOperations {
  final Database database;
  DbOperations({required this.database});

  Future<bool> createNewUser(UserModel user) async {
    bool _done = false;
    await database
        .createNewUser(user)
        .then((value) => _done = true)
        .catchError((error) {
      _done = false;
      print("Failed to add user: $error");
    });
    return _done;
  }

  Future<bool> insertToken(String token) async {
    bool _done = false;
    await database
        .insertToken(token)
        .then((value) => _done = true)
        .catchError((error) {
      _done = false;
      print("Failed to add token: $error");
    });
    return _done;
  }
}
