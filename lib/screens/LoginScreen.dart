import 'package:allen/Widgets/CustomButton.dart';
import 'package:allen/Services/AuthMethods.dart';
import 'package:allen/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Text(
              'Sign up to Continue!',
              style: TextStyle(
                color: Color.fromARGB(255, 11, 32, 255),
                fontSize: 37,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Image.asset(
            'assets/images/login-image.png',
          ),
          const SizedBox(
            height: 40,
          ),
          CustomButton(
              label: const Text('Login'),
              icon: const Icon(
                Icons.login_outlined,
              ),
              onPressed: () async {
                await AuthMethods().signInWithGoogle();
                print('success');
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, HomeScreen.routeName);
              })
        ],
      ),
    );
  }
}
