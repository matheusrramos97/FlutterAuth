import 'package:flutter_auth/pages/utils/authButton.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../utils/authController.dart';

class HomePage extends StatelessWidget {
  final UserModel user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Home',
        ),
      ),
      body: _HomePage(
        user: user,
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  final UserModel user;
  _HomePage({Key? key, required this.user}) : super(key: key);

  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(user.photoURL)),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Name: " + user.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Email: " + user.email,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Sign In Method: " + user.signInMethod,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            AuthButton(
              label: 'Sign Out',
              onPressed: () {
                authController.removeUser(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
