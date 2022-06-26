import 'package:lkarnet/database/database.dart';
import 'package:lkarnet/models/user/user.dart';

class DatabaseOperations {
  final Database _database;
  DatabaseOperations(this._database);

  /// create user in database
  Future<void> createUser(UserModel user) async {
    await _database.createNewUser(user);
  }

  /// get user from database
  Future<UserModel?> getUser() async {
    return await _database.getUser();
  }

  /// update user in database
  Future<void> updateUser(UserModel user) async {
    await _database.updateUser(user);
  }
}
