import 'package:flutter/scheduler.dart';
import 'package:mycart/screens/drawer_screen.dart';
import 'package:mycart/screens/get_started.dart';
import 'package:mycart/screens/sign_in.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Function> iniApp() async {
    await DataManager.mPrefManager.loadDataFromLocalMemory();
    if (DataManager.mPrefManager.isLoggedIn()) {
      await DataManager.iniUserAddresses();
      await DataManager.iniMainMenuCategories();
      await DataManager.iniMainMenuItems();
    }
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (DataManager.mPrefManager.isLoggedIn()) {
            print("Already Logged In");
            return DrawerScreen();
          } else {
            if (DataManager.mPrefManager.isLangSet()) {
              return SignInScreen();
            } else {
              return GetStartedScreen();
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    iniApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          brightness: Brightness.dark,
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF00d466),
                  Color(0xFF00af87),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/main/back.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(30.0),
            child: Image.asset(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? "assets/images/main/logo.png"
                  : "assets/images/main/logo_c.png",
              width: 300,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height - 150),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SpinKitSquareCircle(
                color: Color(0xFF00af87),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
