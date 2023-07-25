import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/user_dm.dart';
import 'package:to_do/utiles/app_color.dart';

import '../../../setting/setting_provider.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController describtionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  late SettingProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add new Task',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
                labelText: 'enter your task',
                hintStyle: TextStyle(
                    color: AppColor.lightGray,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
              controller: describtionController,
              decoration: const InputDecoration(
                labelText: 'enter your task describtion',
                hintStyle: TextStyle(
                    color: AppColor.lightGray,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 20,
          ),
          Text(
            'select time',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          InkWell(
            onTap: () {
              showMyDatePicker();
            },
            child: Text(
              textAlign: TextAlign.center,
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColor.lightGray),
            ),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                onAddPress();
              },
              child: const Text('add'))
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }

  void onAddPress() {
    CollectionReference todos = FirebaseFirestore.instance
        .collection('users')
        .doc(UserDm.currentUser!.id)
        .collection('todos');
    DocumentReference docs = todos.doc();
    docs.set({
      "id": docs.id,
      "title": titleController.text,
      "description": describtionController.text,
      "isDone": false,
      "date": selectedDate.millisecondsSinceEpoch
    }).timeout(const Duration(milliseconds: 500), onTimeout: () {
      provider.refreshTodoFromFireStore();
      Navigator.pop(context);
    });
  }
}
