import 'package:firebase_auth/firebase_auth.dart';
import 'package:peer_produce/models/user.dart';
import 'package:peer_produce/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on Firebase User
  MyUser _userFromFirebaseUser(User user) {
    return user != null
        ? MyUser(uid: user.uid, isVerified: user.emailVerified)
        : null;
  }

  // auth change user stream
  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in Anonymously
  Future signInAnonymously() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(credential.user);
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      return e.message.toString();
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser.sendEmailVerification();

      // create a new doc for the user
      await DatabaseService(uid: credential.user.uid)
          .updateUserData('0', 'new member', 100);

      // sign out
      signOut();

      return _userFromFirebaseUser(credential.user);
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      return e.message.toString();
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // check email verification
  bool isVerified() {
    return _auth.currentUser.emailVerified;
  }

  // send verification email
  void sendVerificationEmail() {
    _auth.currentUser.sendEmailVerification();
    signOut();
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
