import 'package:flutter/material.dart';
import 'package:money_managment/models/Money.dart';
import 'package:money_managment/screens/Home_screen.dart';
import 'package:money_managment/screens/main_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox('moneyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  static void getData(){
    HomeScreen.moneys.clear();
    Box<Money>hiveBox = Hive.box<Money>('moneyBox');
    for (var element in hiveBox.values){
      HomeScreen.moneys.add(element);
    }
  }
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