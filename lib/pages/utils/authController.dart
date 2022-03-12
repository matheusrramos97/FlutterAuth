import 'package:flutter_auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  FirebaseAuth auth = FirebaseAuth.instance;

  void resetPassword(String email, BuildContext context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'check your email!',
        style: TextStyle(color: Colors.green),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    ));
    Navigator.pushReplacementNamed(context, "/login");
  }

  void setUser(UserModel? user, BuildContext context) {
    if (user != null) {
      saveUser(user, context);
      _user = user;
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  void removeUser(BuildContext context) async {
    auth.signOut();

    final instance = await SharedPreferences.getInstance();
    instance.remove('user');
    Navigator.pushReplacementNamed(context, "/splash");
  }

  Future<void> saveUser(UserModel user, BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString('user', user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 2));
    if (instance.containsKey('user')) {
      final currentUserJson = instance.getString('user') as String;
      setUser(UserModel.fromJson(currentUserJson), context);
      return;
    } else {
      setUser(null, context);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    print("signInWithGoogle() init");
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    print("signInWithGoogle()");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        final name = userCredential.user!.displayName != null
            ? userCredential.user!.displayName
            : userCredential.user!.email.toString();
        final photoURL = userCredential.user!.photoURL != null
            ? userCredential.user!.photoURL
            : "https://img.freepik.com/free-vector/flat-design-no-photo-sign_23-2149259323.jpg?w=120";

        if (name == null && photoURL == null) {
          debugPrint("Name: " + name.toString());
          debugPrint("photoURL: " + photoURL.toString());
        }

        UserModel currentUser = UserModel(
            email: userCredential.user!.email.toString(),
            name: name.toString(),
            photoURL: photoURL.toString(),
            signInMethod: "Email And Password");
        saveUser(currentUser, context);
        Navigator.pushReplacementNamed(context, "/splash",
            arguments: currentUser);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'No user found for that email.',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Wrong password provided for that user.',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        final name = userCredential.user!.displayName != null
            ? userCredential.user!.displayName
            : userCredential.user!.email.toString();

        final photoURL = userCredential.user!.photoURL != null
            ? userCredential.user!.photoURL
            : "https://img.freepik.com/free-vector/flat-design-no-photo-sign_23-2149259323.jpg?w=120";

        debugPrint(userCredential.credential.toString());
        UserModel currentUser = UserModel(
            email: userCredential.user!.email.toString(),
            name: name.toString(),
            photoURL: photoURL.toString(),
            signInMethod: "Email And Password");
        saveUser(currentUser, context);
        Navigator.pushReplacementNamed(context, "/splash",
            arguments: currentUser);
      }
      Navigator.pushReplacementNamed(
        context,
        "/splash",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'The password provided is too weak.',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'The account already exists for that email.',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
