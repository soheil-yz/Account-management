import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_managment/Constans.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo[200],
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
              const ScopTextField(
                hintText: 'Description',
              ),
              const ScopTextField(
                hintText: 'Cost',
                type: TextInputType.number,
              ),
              TypeAndDate(),
              SizedBox(height: 15,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: KPurpleColor,
                    elevation: 0
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TypeAndDate extends StatelessWidget {
  const TypeAndDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: MyRadioButton(
            value: 0,
            text: "Payment",
            groupValue: 1000,
            onChanged: (value) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: MyRadioButton(
            value: 1,
            text: "Receipt",
            groupValue: 1000,
            onChanged: (value) {},
          ),
        ),
        Center(
          child: Container(
            width: 90,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor:KPurpleColor ,elevation: 0),
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
  final TextInputType type;
  const ScopTextField(
      {super.key, required this.hintText, this.type = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
