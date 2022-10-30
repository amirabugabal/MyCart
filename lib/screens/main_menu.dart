import 'package:mycart/screens/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/main_menu/main_menu_item.dart';

class MainMenuScreen extends StatefulWidget {
  static const appBarTitle = 'Home';
  static const routeName = '/main-menu';

  @override
  MainMenuScreenState createState() {
    return MainMenuScreenState();
  }
}

class MainMenuScreenState extends State<MainMenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        leading: Padding(
          padding: EdgeInsets.only(left: 2, right: 2, top: 3, bottom: 3),
          child: IconButton(
            icon: Image.asset('assets/images/ic_launcher.png'),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 3, right: 15, top: 5, bottom: 5),
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () =>
                  Navigator.pushNamed(context, MyCartScreen.routeName),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 22, left: 30, right: 30, bottom: 22),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Hello '+ DataManager.userName + ', ',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Image(
                    image: AssetImage(
                      "assets/images/holders/banner_holder.png",
                    ),
                  ),
                ),
                Column(
                  children:[
                  for(int i = 0 ; i < DataManager.products.length ; i+=2)
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          mainMenuItem(context, DataManager.products[i]),
                          SizedBox(
                            width: 10,
                          ),
                          DataManager.products.length > i+1 ? mainMenuItem(context, DataManager.products[i + 1]) : SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
