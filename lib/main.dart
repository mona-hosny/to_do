import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/routes/screenes/home/screen_home.dart';
import 'package:to_do/routes/screenes/login/login.dart';
import 'package:to_do/routes/screenes/register/register.dart';
import 'package:to_do/setting/setting_provider.dart';
import 'package:to_do/utiles/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  runApp(
      ChangeNotifierProvider(create: (_) => SettingProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  String currentLocal = 'en';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SettingProvider provider = Provider.of(context);
    return MaterialApp(
      themeMode: provider.currentTheme,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // arabic
      ],
      locale: Locale(provider.currentLocal),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        Login.routeName:(_)=> Login(),
        Register.routeName:(_)=> Register()
      },
      initialRoute: Login.routeName,
    );
  }
}
