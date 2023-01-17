import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mycart/models/recent_orders/recent_orders.dart';
import 'package:mycart/screens/my_cart.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/recent_orders/recent_orders_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyMessagesScreen extends StatefulWidget {
  static const appBarTitle = 'Messages';
  static const routeName = '/view-messages';

  @override
  MyMessagesScreenState createState() {
    return MyMessagesScreenState();
  }
}

class MyMessagesScreenState extends State<MyMessagesScreen> {
  final databaseRef = FirebaseDatabase.instance.reference();
  bool isLoading = true;
  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
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
              'View Messages',
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
          body: FutureBuilder(
              future: DataManager.getAllMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            new Card(
                              child: new Container(
                                width: MediaQuery.of(context).size.width,
                                padding: new EdgeInsets.all(32.0),
                                child: new Column(
                                  children: <Widget>[
                                    Text(snapshot.data[index].message
                                        .toString()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          //Text(snapshot.data[index].data["name"]),
                        );
                      });
                }
              }),
        ));
  }
}
