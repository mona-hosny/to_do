import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/todo_dm.dart';
import 'package:to_do/setting/setting_provider.dart';

import 'todo.dart';

class ListOfTasks extends StatefulWidget {
  @override
  State<ListOfTasks> createState() => _ListOfTasksState();
}

class _ListOfTasksState extends State<ListOfTasks> {
  late SettingProvider provider = Provider.of(context);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500),(){provider.refreshTodoFromFireStore();});

  }
  @override
  Widget build(BuildContext context) {
     provider = Provider.of(context);

    return ListView.builder(
        itemCount: provider.todosList.length,
        itemBuilder: (context, index) {
          return Todo(
              todo:
                  provider.todosList[index]);


          });
  }
}
