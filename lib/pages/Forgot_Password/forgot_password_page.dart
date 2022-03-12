import 'package:flutter_auth/pages/utils/authButton.dart';
import 'package:flutter_auth/pages/utils/authController.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final textEC = TextEditingController();
  final authController = AuthController();

  @override
  void dispose() {
    textEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('FORGOT PASSWORD'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Don't worry, happens to the best of us",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black,
                thickness: 3,
              ),
              const Text(
                'Please enter your email adress. You will receive a link to create a new password via email.',
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Colors.black,
                thickness: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "E-MAIL",
                ),
                controller: textEC,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationBuilder().email().maxLength(50).build(),
              ),
              const SizedBox(
                height: 10,
              ),
              AuthButton(
                label: 'Reset Password',
                onPressed: () async {
                  final email = textEC.text.toString();
                  if (email.contains("@") && email.contains('.com')) {
                    authController.resetPassword(email, context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                        'invalid email, try again',
                        style: TextStyle(color: Colors.red),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
