import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_managment/Constans.dart';
import 'package:money_managment/main.dart';
import 'package:money_managment/models/Money.dart';
import 'package:money_managment/screens/Home_screen.dart';
import 'package:money_managment/screens/main_screen.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});
  static int groupId = 0;
  static int index = 0;
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static bool isEditing = false;
  static String Date = 'Date';
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
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
              Text(
                NewScreen.isEditing ? "Edit transaction" : "New transaction",
                style: TextStyle(fontSize: 18),
              ),
              ScopTextField(
                hintText: 'Description',
                controller: NewScreen.descriptionController,
              ),
              ScopTextField(
                hintText: 'Cost',
                controller: NewScreen.priceController,
                type: TextInputType.number,
              ),
              TypeAndDate(),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: Expanded(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: KPurpleColor, elevation: 0),
                    onPressed: () {
                      //HomeScreen.moneys.add(
                      Money Item = Money(
                        id: Random().nextInt(9999),
                        price: NewScreen.priceController.text,
                        date: NewScreen.Date,
                        isReceived: NewScreen.groupId == 1 ? true : false,
                        title: NewScreen.descriptionController.text,
                      );
                      if (NewScreen.isEditing) {
                        int Id = 0;
                        MyApp.getData();
                        for (int i = 0; i < hiveBox.values.length; i++) {
                          if (hiveBox.values.elementAt(i).id == NewScreen.index) {
                            Id = i;
                          }
                        }
                        //HomeScreen.moneys[NewScreen.index] = Item;
                        hiveBox.putAt(Id, Item);
                      } else {
                        //  HomeScreen.moneys.add(Item);
                        hiveBox.add(Item);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      NewScreen.isEditing ? "Edit" : "Add",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: Text('back'),
              ),
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
          child: Expanded(
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
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Expanded(
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
        ),
        Center(
          child: Container(
            width: 100,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: KPurpleColor, elevation: 0),
                onPressed: () async {
                  var pickedDate = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1403),
                      lastDate: Jalali(1499));
                      setState(() {
                        NewScreen.Date = pickedDate!.year.toString() +'/'+  pickedDate.month.toString() +'/'+  pickedDate.day.toString();
                      });
                },
                child: Text(
                  NewScreen.Date,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
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
      {super.key,
      required this.hintText,
      this.type = TextInputType.text,
      required this.controller});

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
