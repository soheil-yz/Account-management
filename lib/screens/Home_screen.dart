import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_managment/Constans.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo[200],
        floatingActionButton: FloatingActionButton(
            backgroundColor: KPurpleColor,
            elevation: 0,
            onPressed: () {},
            child: const Icon(
              Icons.add,
            )),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              HeaderWidget(SearchController: SearchController),
              const Expanded(child: EmptyWight())
            ],
          ),
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
              SizedBox(height: 10,),
              const Text("There is no transaction !"),
              const Spacer(),
      ],
    );
  }
}