import 'package:flutter/material.dart';
import 'package:money_managment/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'google'),
      debugShowCheckedModeBanner: false,
      title: 'مدیرت مالی',
      home: MainScreen(),
    );
  }
}