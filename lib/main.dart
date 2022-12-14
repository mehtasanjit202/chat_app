import 'package:chatapp/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppSetting.navigatorKey,
      title: ("Chat App"),
      home: const LoginScreen(),
    );
  }
}



class AppSetting {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
