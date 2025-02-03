import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  var message = "";

  UserModel _currentUser = UserModel(
    id: "",
    firstName: "",
    email: "",
  );
  bool isPassed = false;
  Future signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user!;
      UserModel currentUser = UserModel(
        id: user.uid,
        firstName: name,
        email: email,
      );
      message = "successfully-signed-up";
      isPassed = true;
      await addUserProfileToFireStore(currentUser);
    } on FirebaseAuthException catch (e) {
      print("error ${e.code}");
      message = e.code;
      isPassed = false;
    }
    return {
      "message": message,
      "isPassed": isPassed,
    };
  }

  addUserProfileToFireStore(UserModel userModel) async {
    print("object addUserProfileToFireStore");
    await firebaseFirestore
        .collection("Users")
        .doc(userModel.id)
        .set(userModel.toMap());
  }

  Future<UserModel> getcurrentUser() async {
    User? user = _firebaseAuth.currentUser;
    UserModel currentUser = UserModel(
      id: "",
      firstName: "",
      email: "",
    );

    var userDocument =
        await firebaseFirestore.collection("Users").doc(user!.uid).get();

    currentUser = UserModel(
      id: user.uid,
      firstName: userDocument['firstName'],
      email: userDocument['email'],
    );
    print("object currentUser ${currentUser.firstName}");
    return currentUser;
  }

  Future signIn({required String email, required String password}) async {
    message = "something-went-wrong";
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = authResult.user!;
      print("object ${authResult.user!.email}");
      // get data from user collection
      firebaseFirestore
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((value) => {
                _currentUser = UserModel(
                  id: user.uid,
                  firstName: value['firstName'],
                  email: value['email'],
                )
              });
      print("successfully ${_currentUser.firstName} logged in");
      message = "successfully-logged-in";
      isPassed = true;
    } on FirebaseAuthException catch (e) {
      print("error ${e.code}");
      message = e.code;
      isPassed = false;
    }

    return {
      "message": message,
      "isPassed": isPassed,
    };
  }
}
