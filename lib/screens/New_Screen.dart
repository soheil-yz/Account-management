import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_managment/Constans.dart';
import 'package:money_managment/models/Money.dart';
import 'package:money_managment/screens/Home_screen.dart';
import 'package:money_managment/screens/main_screen.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});
  static int groupId = 0;
  static int soheil = 0;
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.indigo[200],
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "New transaction",
                style: TextStyle(fontSize: 18),
              ),
               ScopTextField(
                hintText: 'Description' , controller: NewScreen.descriptionController,
              ),
               ScopTextField(
                hintText: 'Cost', controller: NewScreen.priceController,
                type: TextInputType.number,
              ),
              TypeAndDate(),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: KPurpleColor, elevation: 0),
                  onPressed: () {
                    HomeScreen.modeys.add(
                      Money(
                        id: Random().nextInt(9999) ,
                        price: NewScreen.priceController.text,
                        date: '1403/02/05',
                        isReceived: NewScreen.groupId == 1 ? true : false,
                        title: NewScreen.descriptionController.text),
                        );
                      Navigator.pop(context);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(onPressed: (){
                Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
              }, child: Text('back'),),
            ],
          ),
        ),
      ),
    );
  }
}

class TypeAndDate extends StatefulWidget {
  const TypeAndDate({
    super.key,
  });

  @override
  State<TypeAndDate> createState() => _TypeAndDateState();
}

class _TypeAndDateState extends State<TypeAndDate> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: MyRadioButton(
            value: 1,
            text: "Payment",
            groupValue: NewScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewScreen.groupId = value!;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: MyRadioButton(
            value: 2,
            text: "Receipt",
            groupValue: NewScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewScreen.groupId = value!;
              });
            },
          ),
        ),
        Center(
          child: Container(
            width: 90,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: KPurpleColor,
                   elevation: 0),
              onPressed: () {},
              child: const Text(
                'Date',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String text;

  const MyRadioButton(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(text),
        Radio(
          activeColor: KPurpleColor,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        )
      ],
    );
  }
}

class ScopTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType type;
  const ScopTextField(
      {super.key, required this.hintText, this.type = TextInputType.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.black87,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: hintText),
    );
  }
}
