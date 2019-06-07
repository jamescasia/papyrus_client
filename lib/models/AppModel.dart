import 'package:scoped_model/scoped_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'EditReceiptScreenModel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

enum Period { MONTHLY, WEEKLY, DAILY }

class AppModel extends Model {
  User _user;
  Period _viewing_period = Period.DAILY;
  bool _alsoReceivePromosThruEmail;
  bool _receiveUniquePromos;
  bool _receiveOpenToAllPromos;
  List<String> _receipts_json_paths;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // FirebaseAuth mAuth;

  User get user => _user;
  bool get alsoReceivePromosThruEmail => _alsoReceivePromosThruEmail;
  Period get viewing_period => _viewing_period;
  bool get receiveUniquePromos => _receiveUniquePromos;
  bool get receiveOpenToAllPromos => _receiveOpenToAllPromos;

  String directoryPath;
  EditReceiptScreenModel editReceiptScreenModel = EditReceiptScreenModel();
  // ChartScreenModel chartScreenModel;

  AppModel() {
    init();
  }

  void init() { 

    // mAuth = FirebaseAuth.instance;
 
  }

   login(String email , String password)async { 

      //  mAuth.signInWithEmailAndPassword(email: email, password:  password );
      //  print("Signed in: " + mAuth.currentUser().toString());


      // user.fbUser = await _handleSignIn();

  }



//   Future<FirebaseUser> _handleSignIn() async {
//   final GoogleSignInAccount googleUser = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   final AuthCredential credential = GoogleAuthProvider.getCredential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   final FirebaseUser user = await mAuth.signInWithCredential(credential);
//   print("signed in " + user.displayName);
//   return user;
// }

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  set receiveUniquePromos(bool value) {
    _receiveUniquePromos = value;
    notifyListeners();
  }

  set receiveOpenToAllPromos(bool value) {
    _receiveOpenToAllPromos = value;
    notifyListeners();
  }

  set alsoReceivePromosThruEmail(bool value) {
    _alsoReceivePromosThruEmail = value;
    notifyListeners();
  }

  set viewing_period(Period period) {
    _viewing_period = period;
    notifyListeners();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}

class User {
  String username;
  String uid;
  // FirebaseUser fbUser;
}
