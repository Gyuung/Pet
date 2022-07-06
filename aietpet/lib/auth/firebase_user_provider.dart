import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AietpetFirebaseUser {
  AietpetFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

AietpetFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AietpetFirebaseUser> aietpetFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<AietpetFirebaseUser>(
        (user) => currentUser = AietpetFirebaseUser(user));
