import 'package:mycart/models/recent_orders/recent_orders.dart';
import 'package:mycart/screens/my_cart.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/recent_orders/recent_orders_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyOrdersScreen extends StatefulWidget {
  static const appBarTitle = 'My Orders';
  static const routeName = '/my-orders';

  @override
  MyOrdersScreenState createState() {
    return MyOrdersScreenState();
  }
}

class MyOrdersScreenState extends State<MyOrdersScreen> {
  bool isLoading = true;

  @override
  void initState() {
    iniRecentOrders();
  }

  Future<void> iniRecentOrders() async {
    await DataManager.iniRecentOrders().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    !isLoading ?? print(DataManager.recentOrders.length);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        centerTitle: true,
        title: Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      body: isLoading
          ? Container(
              alignment: Alignment.center,
              child: SpinKitSquareCircle(
                color: Color(0xFF00af87),
                size: 20,
              ),
            )
          : ListView(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 22, left: 30, right: 30, bottom: 22),
                  child: Column(
                    children: [
                      if (DataManager.recentOrders != null &&
                          DataManager.recentOrders.length > 0)
                        for (RecentOrdersClass oItem
                            in DataManager.recentOrders)
                          RecentOrdersItemsWidget(
                              context, oItem, toggleIsLoading),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
