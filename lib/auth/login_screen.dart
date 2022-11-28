

import 'package:chatapp/auth/signup_screen.dart';
import 'package:chatapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Homepage/Home_page.dart';
import '../utils/snacks.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
  bool _isObscure=true;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();


  _loginUser(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        Navigator.of(AppSetting.navigatorKey.currentContext!).pushAndRemoveUntil( MaterialPageRoute(builder: (context) => const Homepage()),(route)=> false);
        showSuccessSnacks("Logged In successfully");
      } else {
        showErrorSnacks("Something went Wrong");
      }
    } on FirebaseAuthException catch (e) {
      showErrorSnacks(e.message.toString());
    } catch (e) {
      showErrorSnacks(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
         key: _loginFormKey,
        child: Column(
         
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              validator: (value) {
                if (value != null &&
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                  return null;
                } else {
                  return "Please enter a valid Email";
                }
              },
            ),
            TextFormField(
              obscureText: _isObscure,
              controller: _passwordController,
              decoration:  InputDecoration(labelText: "Password",suffixIcon: IconButton(onPressed: (){setState(() {
                _isObscure?_isObscure=false:_isObscure=true;
                
              });
              }, icon: const Icon(Icons.remove_red_eye)
              ),
              ),
              validator: (value) {
                {
                  if (value != null && value.length > 7) {
                    return null;
                  } else {
                    return " Please Provide Minimum 8 Character";
                  }
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_loginFormKey.currentState!.validate()) {
                  _loginUser(_emailController.text, _passwordController.text);
                }
                //print("password" + _passwordController.text);
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                );
              },
              child: const Text("Don't have a Sign Up Account? Sign up"),
            )
          ],
        ),
      ),
    );
  }
}
