import 'package:flutter/material.dart';
import 'package:money_managment/Constans.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPurpleColor,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
        
      }, 
      child: const Icon(Icons.add,)),
    );
  }
}