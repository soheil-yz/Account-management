//import 'dart:js_interop';

// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:money_managment/Constans.dart';
import 'package:money_managment/main.dart';
import 'package:money_managment/models/Money.dart';
import 'package:money_managment/screens/New_Screen.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<Money> moneys = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController SearchController = TextEditingController();
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  void initState() {
    MyApp.getData();
    super.initState();
  }

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
            NewScreen.isEditing = false;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewScreen(),
              ),
            ).then(
              (value) {
                setState(
                  () {
                    MyApp.getData();
                  },
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              HeaderWidget(),
              //const Expanded(child: EmptyWight()),
              Expanded(
                child: HomeScreen.moneys.isEmpty
                    ? EmptyWight()
                    : ListView.builder(
                        itemCount: HomeScreen.moneys.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            //!Edit
                            onDoubleTap: () {
                              NewScreen.descriptionController.text =
                                  HomeScreen.moneys[index].title;
                              NewScreen.priceController.text =
                                  HomeScreen.moneys[index].price;
                              NewScreen.groupId =
                                  HomeScreen.moneys[index].isReceived ? 1 : 2;
                              NewScreen.isEditing = true;
                              NewScreen.index = index;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NewScreen(),
                                ),
                              ).then((value) {
                                MyApp.getData();
                                setState(() {});
                              });
                            },
                            //!Removed
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                      "Are you sure you want to delete it?",
                                      style: TextStyle(fontSize: 15)),
                                  actions: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                hiveBox.deleteAt(index);
                                                MyApp.getData();
                                                // HomeScreen.moneys
                                                //     .removeAt(index);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              "YES",
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "NO",
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: MyListTileWedget(index: index),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget HeaderWidget() {
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
              onFieldSubmitted: (String text) {
                List<Money> result = hiveBox.values
                    .where((element) =>
                        element.title.contains(text) ||
                        element.date.contains(text))
                    .toList();
                HomeScreen.moneys.clear();
                setState(() {
                  for (var item in result) {
                    HomeScreen.moneys.add(item);
                  }
                });
              },
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
                color: HomeScreen.moneys[index].isReceived
                    ? KGreenColor
                    : KRedColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(
                  HomeScreen.moneys[index].isReceived
                      ? Icons.add
                      : Icons.remove_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(HomeScreen.moneys[index].title),
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
                      HomeScreen.moneys[index].price,
                      style: TextStyle(fontSize: 15, color: KRedColor),
                    ),
                  ],
                ),
                Text(HomeScreen.moneys[index].date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class HeaderWidget extends StatefulWidget {
//   HeaderWidget({
//     super.key,
//     required this.SearchController,
//   });

//   final TextEditingController SearchController;

//   @override
//   State<HeaderWidget> createState() => _HeaderWidgetState();
// }

// class _HeaderWidgetState extends State<HeaderWidget> {
//   Box<Money> hiveBox = Hive.box<Money>('moneyBox');

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//   padding: const EdgeInsets.only(right: 20, top: 20, left: 5),
//   child: Row(
//     children: [
//       Expanded(
//         child: SearchBarAnimation(
//           textEditingController: widget.SearchController,
//           isOriginalAnimation: false,
//           trailingWidget: Icon(Icons.search),
//           secondaryButtonWidget: Icon(Icons.search_off),
//           buttonWidget: Icon(Icons.search),
//           buttonElevation: 0,
//           onFieldSubmitted: (String text) {
//             List<Money> result = hiveBox.values
//                 .where((element) =>
//                     element.title.contains(text) ||
//                     element.date.contains(text))
//                 .toList();
//                 HomeScreen.moneys.clear();
//                 setState(() {
//                   for (var item in result){
//                     HomeScreen.moneys.add(item);
//                   }
//                 });
//           },
//         ),
//       ),
//       const SizedBox(
//         width: 10,
//       ),
//       const Text('Transactions'),
//     ],
//   ),
// );
//   }
// }

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
