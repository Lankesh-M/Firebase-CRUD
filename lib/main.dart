import 'package:crud/features/user_auth/presentation/pages/login_page.dart';
import 'package:crud/firebase_options.dart';
import 'package:crud/pages/home.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crud/features/app/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //Used in - Navigator.pushNamed(context, route),
        '/home': (context) => const Home(),
        '/Login': (context) => const LoginPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Mental-Health',
      debugShowMaterialGrid: false,
      home: SplashScreen(child: LoginPage()),
    );
  }
}
