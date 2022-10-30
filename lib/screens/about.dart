import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  static const routeName = '/about-us';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<AboutUs> {

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
    body: Scaffold(
    appBar: AppBar(
    toolbarHeight: 65,
    automaticallyImplyLeading: false,
    leadingWidth: 65,
    title: Text(
    'About Us',
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
      body: ListView(
        children: [
          SizedBox(height: 25),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Text(
                  'My Cart is an E-Commerce Application that is multi-platform, we offer all kinds of items and categories for you to choose from.  ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.all(20),
            ),
          ),
        ],
      ),
    ));
  }
}
