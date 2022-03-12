import 'package:flutter_auth/pages/utils/authButton.dart';
import 'package:flutter_auth/pages/utils/socialButtons.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import '../utils/authController.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('REGISTER'),
        centerTitle: true,
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final authController = AuthController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
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
          const SizedBox(
            height: 10,
          ),
          AuthButton(
            label: 'Register',
            onPressed: () {
              final email = emailEC.text.toString();
              final password = passwordEC.text.toString();
              if (email.contains("@") &&
                  email.contains('.com') &&
                  password.length >= 6) {
                authController.createUserWithEmailAndPassword(
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
            'OR SIGN UP USING',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          const SocialButtons(),
        ],
      ),
    );
  }
}
