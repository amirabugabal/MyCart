import 'package:mycart/screens/about.dart';
import 'package:mycart/screens/checkout.dart';
import 'package:mycart/screens/order_placed.dart';
import 'package:mycart/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:mycart/services/data_manager.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTitle(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints.expand(),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF89CFF0),
                            Color(0xFF0047AB),
                      ],
                    ),
                  ),
                ),
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
                  margin: EdgeInsets.all(25.0),
                  child: Image.asset(
                    "assets/images/main/logo.png",
                    width: 300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          buildListTitle(
            'Order Placed',
            Icons.verified,
            () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, OrderPlacedScreen.routeName);
            },
          ),
          buildListTitle(
            'Checkout',
            Icons.money,
            () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, CheckoutScreen.routeName);
            },
          ),
          buildListTitle(
            'About Us',
            Icons.info_outline,
            () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, AboutUs.routeName);
            },
          ),
          buildListTitle(
            'Logout',
            Icons.logout,
            () {
              DataManager.isLoggedIn = false;
              DataManager.userName = "";
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            },
          ),
          
        ],
      ),
    );
  }
}
