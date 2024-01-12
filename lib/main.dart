import 'package:flutter/material.dart';
import 'package:instagram/screens/basic_screen.dart';
import 'package:instagram/screens/chat_screen.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: '/home',
      routes: {
        '/': (context) => login_screen(),
        '/register': (context) => Registration_screen(),
        '/chat': (context) => ChatScreen(),
        '/home': (context) => main_window()
      },
    );
  }
}
