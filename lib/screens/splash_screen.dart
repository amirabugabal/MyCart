import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycart/screens/drawer_screen.dart';
import 'package:mycart/screens/sign_in.dart';
import 'package:mycart/services/data_manager.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    iniApp();
    super.initState();
  }

  Future<void> iniApp () {
    Future.delayed(const Duration(milliseconds: 1500), () {
      if(DataManager.isLoggedIn){
            Navigator.of(context).pushReplacementNamed(DrawerScreen.routeName);
          }else{
            Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
          }
    });
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
                  Color(0xFF89CFF0),
                  Color(0xFF0047AB),
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
                color: Color(0xFF89CFF0),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
