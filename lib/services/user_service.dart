import 'package:crud_sqllite_app/db_helper/repository.dart';
import 'package:crud_sqllite_app/model/user.dart';
import 'dart:async';

class UserService {
  late Repository repository;

  UserService() {
    repository = Repository();
  }

  //save user
  saveUser(User user) async {
    return await repository.insertData("users", user.userMap());
  }

  //read all users
  readAllUser() async {
    return await repository.readData("users");
  }

  //edit all users
  updateUser(User user) async {
    return await repository.updateData("users", user.userMap());
  }

  deleteUser(userId) async {
    return await repository.deleteDataById("users", userId);
  }
}
