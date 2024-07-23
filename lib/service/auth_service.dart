import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return auth.signInWithCredential(credential);
  }

  Future<void> logOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<User?> register(
      {required String email, required String password}) async {
    User? user;

    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;
    } catch (e) {
      Logger().e("EXCEPTION: ${e.toString()}");
    }
    return user;
  }

  Future<User?> signIn({required String email, required String psw}) async {
    User? user;

    try {
      UserCredential credential =
          await auth.signInWithEmailAndPassword(email: email, password: psw);
      user = credential.user;
    } catch (e) {
      Logger().e("EXCEPTION: ${e.toString()}");
    }
    return user;
  }
}
