import 'package:flutter_auth/pages/Forgot_Password/forgot_password_page.dart';
import 'package:flutter_auth/pages/register/register_page.dart';
import 'package:flutter_auth/pages/utils/authController.dart';
import 'package:flutter_auth/pages/utils/socialButtons.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import '../utils/authButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('LOGIN'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "E-MAIL",
              ),
              controller: emailEC,
              keyboardType: TextInputType.emailAddress,
              validator: ValidationBuilder().email().maxLength(50).build(),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "PASSWORD",
              ),
              controller: passwordEC,
              keyboardType: TextInputType.emailAddress,
              validator: ValidationBuilder().email().maxLength(50).build(),
            ),
          ]),
        ),
        TextButton(
          child: Text(
            'FORGOT PASSWORD?',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordPage(),
              ),
            );
          },
        ),
        AuthButton(
          label: 'LOGIN',
          onPressed: () {
            final email = emailEC.text.toString();
            final password = passwordEC.text.toString();
            if (email.contains("@") &&
                email.contains('.com') &&
                password.length >= 6) {
              authController.signInWithEmailAndPassword(
                context,
                email,
                password,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'invalid email or password, try again',
                    style: TextStyle(color: Colors.red),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'OR SIGN IN USING',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        const SocialButtons(),
        const SizedBox(
          height: 25,
        ),
        TextButton(
          child: Text(
            'OR SIGN UP',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
