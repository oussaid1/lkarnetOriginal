import 'package:lkarnet/database/database.dart';
import 'package:lkarnet/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_providers.dart';

final userModelProvider = FutureProvider<UserModel>((ref) {
  final db = ref.watch(databaseProvider);
  return db.getUser();
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
