import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const appBarTitle = 'Home';
  static const routeName = '/main-menu';

  @override
  SearchScreenState createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        actions: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
                autofocus: true,
                controller: searchController,
                decoration:  InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: 'Search',
                  hintStyle:  TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Color(0xFF2E2E2E)
                      : Colors.white,
              child: ListView(
                children: [],
              ),
            )
    );
  }
}
