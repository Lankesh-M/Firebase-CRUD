import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud/global/common/toast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        showToast(
            message:
                "This email address is alredy in use \n Login with your password");
      } else {
        showToast(message: "An error occurred ${e.code} ");
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found" || e.code == 'wrong-password') {
        showToast(message: "Invalid email or password");
      } else {
        showToast(message: "An error occurred ${e.code}");
      }
    }
    return null;
  }
}
