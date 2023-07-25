import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/routes/screenes/home/screen_home.dart';
import 'package:to_do/routes/screenes/register/register.dart';
import 'package:to_do/utiles/app_color.dart';

import '../../../models/user_dm.dart';

class Login extends StatefulWidget {
  static String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColor.secondColor),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          const Text('Welcome back !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
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
            decoration: const InputDecoration(label: Text('Password')),
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
              onPressed: () {

                Navigator.pushNamed(context, HomeScreen.routeName);
              login();

              },
              child: Row(
                children: [ Text('Login'),  Spacer(),  Icon(Icons.arrow_forward)],
              )),const SizedBox(height: 5,),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, Register.routeName);
              },
              child: const Text(
                'Create New Account',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.lightGray),
              ))
        ]),
      ),
    );
  }

  void login()async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      UserDm user =await getUserFromFireStore(credential.user!.uid);
      UserDm.currentUser=user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       showMyDialog(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showMyDialog(message: 'Wrong password provided for that user.');
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
  void saveUserInFireStore(String email,String uid,String userName){
    var userCollection = FirebaseFirestore.instance.collection('users');
    var userDocument = userCollection.doc();
    userDocument.set({
      "id":uid,
      "userName":userName,
      "email":email
    });
  }
  Future<UserDm> getUserFromFireStore(String uid)async{
    var usersCollection = FirebaseFirestore.instance.collection('users');
    var doc = usersCollection.doc(uid);
    DocumentSnapshot snapshot = await doc.get();
    Map json = snapshot.data() as Map;
    UserDm user=UserDm(uid,email,json["userName"]);
    return user;
    

  }
}
