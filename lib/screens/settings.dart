//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mycart/services/data_manager.dart';

class Settings extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = true;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      DataManager.mPrefManager.setIsNotifications(1);
      setState(() {
        isSwitched = true;
      });
    } else {
      DataManager.mPrefManager.setIsNotifications(0);
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  void initState() {
    DataManager.mPrefManager.getIsNotifications().then((value) {
      setState(() {
        isSwitched = (value == 1);
      });
    });
    super.initState();
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
      body: Scaffold(
          appBar: AppBar(
            toolbarHeight: 65,
            automaticallyImplyLeading: false,
            leadingWidth: 65,
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: 15, right: 9, top: 9, bottom: 9),
              child: IconButton(
                icon: Image.asset('assets/images/other_icons/back_arrow.png'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Subscribe to Notifications'),
              ),
              Switch(
                value: isSwitched,
                onChanged: toggleSwitch,
              )
            ],
          )),
    );
  }
}
