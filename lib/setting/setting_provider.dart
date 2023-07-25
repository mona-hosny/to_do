import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/user_dm.dart';

import '../models/todo_dm.dart';

class SettingProvider extends ChangeNotifier {
  String currentLocal = 'en';
  ThemeMode currentTheme = ThemeMode.dark;
  List<TodoDm>todosList=[];

  changeCurrentLocal(String newLocal) {
    currentLocal = newLocal;

    notifyListeners();
  }

  changeCurrentTheme(ThemeMode newTheme) {
    currentTheme = newTheme;

    notifyListeners();
  }
  refreshTodoFromFireStore() {
    var todoCollection = FirebaseFirestore.instance.collection("users").doc(UserDm.currentUser!.id).collection('todos');
    todoCollection.get().then((querySnapshot) {
     todosList= querySnapshot.docs.map((documentSnapshot) {
        var json = documentSnapshot.data();
        return TodoDm(id:json["id"],title: json["title"],
            description: json["description"],
            date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
            isDone: json["isDone"]);
      }).toList();
      notifyListeners();
    },);
  }
}