import 'package:mycart/screens/sign_in.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  static const routeName = '/get-started';

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
          ListView(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                top: 30),
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 30, bottom: 10),
                child: Image.asset(
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? "assets/images/main/logo.png"
                      : "assets/images/main/logo_c.png",
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 40,
                ),
                child: Center(
                  child: Text(
                    "Go on, discover and order NOW.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF00d466),
                      Color(0xFF00af87),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        'Select your language',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 30, left: 40, right: 40, bottom: 30),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 88.0, minHeight: 55),
                            alignment: Alignment.center,
                            child: const Text(
                              'English',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF00af87),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          DataManager.mPrefManager.setLang(1);
                          Navigator.pushReplacementNamed(
                              context, SignInScreen.routeName);
                        },
                      ),
                    ),
                    /*Padding(
                      padding: EdgeInsets.only( left: 40, right: 40, bottom: 30),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 88.0, minHeight: 55),
                            alignment: Alignment.center,
                            child: const Text(
                              'العربية',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF00af87),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          DataManager.mPrefManager.setLang(2);
                          Navigator.pushReplacementNamed(
                              context, SignInScreen.routeName);
                        },
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
