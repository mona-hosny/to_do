import 'package:flutter/material.dart';
import 'package:to_do/models/user_dm.dart';

import 'package:to_do/routes/screenes/home/tabs/setting_tap.dart';
import 'package:to_do/utiles/app_color.dart';

import 'bottomSheet.dart';
import 'tabs/list_of_task/list_of_tasks.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTap = 0;

List<Widget>tabs=[ListOfTasks(),SettingTap()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  const Text('welcome Back '),
          toolbarHeight: MediaQuery
              .of(context)
              .size
              .height * 0.15),
      body: tabs[currentTap],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowAddButtomSheet ();
        },
        child: Icon(
          Icons.add,
          color: AppColor.secondColor,
        ),
        shape: const StadiumBorder(
          side: BorderSide(color: AppColor.secondColor),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
            currentIndex: currentTap,
            onTap: (tappedTap) {
              currentTap=tappedTap;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'list'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'setting')
            ]),
      ),
    );
  }


  void ShowAddButtomSheet() {
    showModalBottomSheet(context: context, builder: (_) => AddBottomSheet());
  }
}
