import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseauthHelper {
  FirebaseauthHelper._();
  static final FirebaseauthHelper firebaseauthHelper = FirebaseauthHelper._();

  static final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInAnonymously() async {
    try {
      UserCredential usercredential = await firebaseauth.signInAnonymously();

      User? user = usercredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'admin-restricted-operation':
          print("===========================");
          print("this operation is restricted to administrators only");
          print("===========================");
          break;
        case 'operation-not-allowed':
          print("===========================");
          print("Anonymous auth hasn't been enabled for this project.");
          print("===========================");
          break;
      }
    }
  }

  Future<User?> signUpUser(
      {required String email, required String password}) async {
    try {
      UserCredential? userCredential = await firebaseauth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  Future<User?> signInUser(
      {required String email, required String password}) async {
    try {
      UserCredential? userCredential = await firebaseauth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("=====================");
        print('No user found for that email.');
        print("=====================");
      } else if (e.code == 'wrong-password') {
        print("=====================");
        print('Wrong password provided for that user.');
        print("=====================");
      }
    }
  }

  Future<User?> signinwithgoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await firebaseauth.signInWithCredential(credential);

    User? user = await userCredential.user;

    return user;
  }

  Future<void> signOut() async {
    await firebaseauth.signOut();
    await googleSignIn.signOut();
  }
}
