import 'package:firebase_auth/firebase_auth.dart';
import 'package:nazarih/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  Userr _userFromFirebaseUser(User user) {
    return user != null ? Userr(uid: user.uid, email: user.email) : null;
  }

  //auth change user stream
  Stream<Userr> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Sign in with Email & Password
  Future signInWithEmailAndPassword(
      String email, String password, String phoneNo) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // phoneNumber = phoneNo;
      return _userFromFirebaseUser(user);
    } catch (e) {
      {
        print(e.toString());
        return e;
      }
    }
  }

  //Register with Email & Password
  Future registerWithEmailAndPassword(
      String email, String password, String phoneNo) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // phoneNumber = phoneNo;
      return _userFromFirebaseUser(user);
    } catch (e) {
      {
        print(e.toString());
        return null;
      }
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
