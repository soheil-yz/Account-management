import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //backgroundColor: Colors.indigo[200],
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, top: 20.0, left: 20.0),
              child: Text('Management of transactions in TMS'),
            ),
            MoneyShowWidget(
              firstName: " : دریافتی امروز ",
              secondPrice: "0",
              secondText: " : پرداختی امروز ",
              firstPrice: '0',
            ),
            MoneyShowWidget(
              firstName: " : دریافتی این ماه ",
              secondPrice: "0",
              secondText: " : پرداختی این ماه ",
              firstPrice: '0',
            ),
            MoneyShowWidget(
              firstName: " : دریافتی امسال ",
              secondPrice: "0",
              secondText: " : پرداختی امسال ",
              firstPrice: '0',
            ),
          ],
        ),
      ),
    ));
  }
}

class MoneyShowWidget extends StatelessWidget {
  final String firstName;
  final String secondText;
  final String firstPrice;
  final String secondPrice;
  MoneyShowWidget(
      {Key? key,
      required this.firstName,
      required this.secondText,
      required this.firstPrice,
      required this.secondPrice})
      : super(key: key);

  // const MoneyShowWidget(
  //     {super.key,
  //     required this.firstName,
  //     required this.secondText,
  //     required this.firstPrice,
  //     required this.secondPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 20.0, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Text(
            secondPrice,
            textAlign: TextAlign.right,
          )),
          Text(
            secondText,
            textAlign: TextAlign.right,
          ),
          Expanded(
            child: Text(firstPrice, textAlign: TextAlign.right),
          ),
          Text(firstName),
        ],
      ),
    );
  }
}
