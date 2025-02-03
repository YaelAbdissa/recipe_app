import 'package:flutter/material.dart';
// import 'package:recipes_app_design/services/auth_services.dart';

import '../models/user_model.dart';
import '../services/auth_services.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  var message = ""; //
  bool isPassed = false;
  String uid = "";

  UserModel currentUser = UserModel(
    id: "",
    firstName: "",
    // lastName: "",
    email: "",
  );

  final _service = AuthServices();

  Future signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    _service.signUp(email: email, password: password, name: name).then((value) {
      print("value of sign up $value");
      message = value["message"];
      isPassed = value["isPassed"];
    });
    return {
      "message": message,
      "isPassed": isPassed,
    };
  }

  Future<dynamic> signIn(
      {required String email, required String password}) async {
    _service.signIn(email: email, password: password).then((value) {
      // print("value of sign in $value");

      message = value["message"];
      isPassed = value["isPassed"];
    });
    return {
      "message": message,
      "isPassed": isPassed,
    };
  }

  Future<UserModel> getCurrentUser() async {
    _service.getcurrentUser().then((value) {
      currentUser = value;
      print("object currentUser getCurrentUser ${currentUser.firstName}");
    });
    return currentUser;
  }
}
