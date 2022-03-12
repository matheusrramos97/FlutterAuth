import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../models/user_model.dart';
import 'authController.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    return Column(
      children: [
        SignInButton(Buttons.Google, onPressed: () async {
          print("SignInButton");
          final response = await authController.signInWithGoogle();
          if (response != null) {
            UserModel currentUser = UserModel(
                email: response.user!.email.toString(),
                name: response.user!.displayName.toString(),
                photoURL: response.user!.photoURL.toString(),
                signInMethod: response.credential!.signInMethod.toString());
            authController.saveUser(currentUser, context);
            Navigator.pushReplacementNamed(context, "/home",
                arguments: currentUser);
          }
        }),
      ],
    );
  }
}
