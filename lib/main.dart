import 'package:flutter_auth/pages/Forgot_Password/forgot_password_page.dart';
import 'package:flutter_auth/pages/Login/login_page.dart';
import 'package:flutter_auth/pages/Home/home_page.dart';
import 'package:flutter_auth/pages/Register/register_page.dart';
import 'package:flutter_auth/pages/Splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlutterAuth());
}

class FlutterAuth extends StatelessWidget {
  const FlutterAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/home": (context) => HomePage(
              user: ModalRoute.of(context)!.settings.arguments as UserModel,
            ),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/splash": (context) => const SplashPage(),
        "/forgotPassword": (context) => const ForgotPasswordPage(),
      },
    );
  }
}
