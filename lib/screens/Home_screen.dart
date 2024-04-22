//import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_managment/Constans.dart';
import 'package:money_managment/models/Money.dart';
import 'package:money_managment/screens/New_Screen.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<Money> modeys = [
    Money(
        id: 0,
        price: '2000',
        date: '2024/27',
        isReceived: false,
        title: 'Univercity'),
    Money(
        id: 1,
        price: '2000',
        date: '2024/27',
        isReceived: true,
        title: 'Programming'),
    Money(
        id: 2, price: '3000', date: '2024/22', isReceived: false, title: 'gym'),
    Money(
        id: 3,
        price: '44000',
        date: '2024/21',
        isReceived: true,
        title: 'handing out'),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.indigo[200],
        floatingActionButton: FloatingActionButton(
            backgroundColor: KPurpleColor,
            elevation: 0,
            onPressed: () {
              NewScreen.descriptionController.text = '';
              NewScreen.priceController.text = '';
              NewScreen.groupId = 0;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewScreen(),
                ),
              ).then((value) => setState(() {
                print('Refresh');
              },),);
            },
            child: const Icon(
              Icons.add,
            )),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              HeaderWidget(SearchController: SearchController),
              //const Expanded(child: EmptyWight()),
              Expanded(
                child: ListView.builder(
                    itemCount: HomeScreen.modeys.length,
                    itemBuilder: (context, index) {
                      return MyListTileWedget(index: index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyListTileWedget extends StatelessWidget {
  final int index;

  const MyListTileWedget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: HomeScreen.modeys[index].isReceived
                    ? KGreenColor
                    : KRedColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(
                  HomeScreen.modeys[index].isReceived
                      ? Icons.add
                      : Icons.remove_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(HomeScreen.modeys[index].title),
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Toman ",
                      style: TextStyle(fontSize: 15, color: KRedColor),
                    ),
                    Text(
                      HomeScreen.modeys[index].price,
                      style: TextStyle(fontSize: 15, color: KRedColor),
                    ),
                  ],
                ),
                Text(HomeScreen.modeys[index].date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.SearchController,
  });

  final TextEditingController SearchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20, left: 5),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              textEditingController: SearchController,
              isOriginalAnimation: false,
              trailingWidget: Icon(Icons.search),
              secondaryButtonWidget: Icon(Icons.search_off),
              buttonWidget: Icon(Icons.search),
              buttonElevation: 0,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Transactions'),
        ],
      ),
    );
  }
}

class EmptyWight extends StatelessWidget {
  const EmptyWight({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          'assets/images/photo.svg',
          height: 200,
          width: 150,
        ),
        SizedBox(
          height: 10,
        ),
        const Text("There is no transaction !"),
        const Spacer(),
      ],
    );
  }
}
