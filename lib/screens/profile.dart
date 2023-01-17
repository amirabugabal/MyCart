import 'package:mycart/models/addresses/user_addresses.dart';
import 'package:mycart/screens/settings.dart';
import 'package:mycart/screens/submit_address_screen.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/profile/user_addresses/user_addresses.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const appBarTitle = 'Profile';
  static const routeName = '/profile';

  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  void updateAddresses() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 80,
        elevation: 0,
        title: new GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProfileScreen.routeName,
            ); //Edit Profile Screen
          },
          child: Text(
            'Edit Profile',
            style: TextStyle(
              color: Color(0xFF00af87),
              fontSize: 14,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 3, right: 15, top: 5, bottom: 5),
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                size: 32,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                Settings.routeName,
              ), // Settings Screen
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
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/other_icons/user_avatar.png",
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          DataManager.mPrefManager.getName(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: <Widget>[
                    for (UserAddressesClass i in DataManager.userAddresses)
                      UserAddressesWidget(context, i, updateAddresses),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 5, right: 3),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF00d466),
                            Color(0xFF00af87),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Container(
                        constraints:
                            const BoxConstraints(minWidth: 88.0, minHeight: 55),
                        alignment: Alignment.center,
                        child: const Text(
                          'Add new address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SubmitAddressScreen(updateAddresses);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
