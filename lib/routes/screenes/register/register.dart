import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/user_dm.dart';
import 'package:to_do/routes/screenes/home/screen_home.dart';

class Register extends StatefulWidget {
  static String routeName = 'register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String userName = '';

  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          TextFormField(
            onChanged: (text) {
              userName = text;
            },
            decoration: const InputDecoration(label: Text('User Name')),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            onChanged: (text) {
              email = text;
            },
            decoration: const InputDecoration(label: Text('Email')),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            onChanged: (text) {
              password = text;
            },
            decoration: const InputDecoration(label: Text('password')),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ElevatedButton(
              onPressed: () {
                registerUser();
              },
              child: const Text('create your account'))
        ]),
      ),
    );
  }

 void registerUser() async {
    try {
      showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );
      await saveUserInFireStore(email, credential.user!.uid, userName);
      hideLoading();
      showMyDialog(
          dialogTitle: 'success', message: 'Created Account Successfully');
      UserDm.currentUser=UserDm(credential.user!.uid,email,userName);
      Navigator.pushNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMyDialog(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showMyDialog(message: 'The account already exists for that email.');
      } else {
        showMyDialog(message: 'some thing wrong try again later');
      }
    }

  }

  void showLoading() {
    showDialog(barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(children: [
            Text('loading...'),
            Spacer(),
            CircularProgressIndicator()
          ]),
        );
      },
    );
  }

  void hideLoading() {
    Navigator.pop(context);
  }

  void showMyDialog({String? dialogTitle, required String message}) {
    showDialog(barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: dialogTitle == null
                ? const SizedBox(
                    height: 5,
                  )
                : Text(dialogTitle),
            content: Text(message),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
  Future saveUserInFireStore(String email,String uid,String userName)async{
    var userCollection = FirebaseFirestore.instance.collection('users');
    var userDocument = userCollection.doc();
    userDocument.set({
      "id":uid,
      "userName":userName,
      "email":email
    });
  }
}
