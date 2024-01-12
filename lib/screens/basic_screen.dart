import 'package:flutter/material.dart';
import 'package:instagram/screens/basic/explore.dart';
import 'package:instagram/screens/basic/home.dart';
import 'package:instagram/screens/basic/notification.dart';
import 'package:instagram/screens/basic/profile.dart';
import 'package:instagram/screens/basic/upload.dart';

class main_window extends StatefulWidget {
  const main_window({super.key});

  @override
  State<main_window> createState() => _main_windowState();
}

class _main_windowState extends State<main_window> {
  int screenIndex = 0;

  List<Widget> screens = [
    Home(),
    explore(),
    Upload(),
    notifications(),
    profile_page()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.message)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            screenIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black38,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore, color: Colors.black38), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.black38), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_add, color: Colors.black38),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black38), label: 'Home'),
        ],
      ),
      body: screens[screenIndex],
    );
  }
}
