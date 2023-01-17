import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mycart/services/data_manager.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final databaseRef = FirebaseDatabase.instance.reference().child('users');

  Future signUp(name, phone, email, password) async {
    final authresult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    databaseRef.child(_auth.currentUser.uid).set({
      'name': name.toString(),
      'phone': phone.toString(),
      'email': email.toString(),
      'type': 'user',
    });
    return authresult;
  }

  Future signIn(String email, String password) async {
    final authresult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    var name = (await FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(_auth.currentUser.uid)
            .child("name")
            .once())
        .value;
    var phone = (await FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(_auth.currentUser.uid)
            .child("phone")
            .once())
        .value;
    var type = (await FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(_auth.currentUser.uid)
            .child("type")
            .once())
        .value;
    await DataManager.mPrefManager.setLoggedInData(
        _auth.currentUser.uid, name, phone, email, password, type);
    return authresult;
  }
}
