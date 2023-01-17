import 'package:mycart/models/addresses/user_addresses.dart';
import 'package:mycart/screens/my_cart.dart';
import 'package:mycart/screens/submit_address_screen.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/main_menu/main_menu_categories.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatefulWidget {
  static const appBarTitle = 'Home';
  static const routeName = '/main-menu';

  @override
  MainMenuScreenState createState() {
    return MainMenuScreenState();
  }
}

class MainMenuScreenState extends State<MainMenuScreen> {
  UserAddressesClass currAddress;

  @override
  void initState() {
    if (DataManager.mPrefManager.getType() == "admin") {
      print("LOGGED IN AS ADMIN");
    }
    for (UserAddressesClass i in DataManager.userAddresses) {
      if (i.id == DataManager.mPrefManager.getSelectedAddress()) {
        currAddress = i;
      }
    }
    super.initState();
  }

  void selectedAddressChanged(UserAddressesClass newAddress) {
    setState(() {
      currAddress = newAddress;
    });
  }

  void addedAddress() {
    if (DataManager.userAddresses != null &&
        DataManager.userAddresses.length > 0) {
      selectedAddressChanged(DataManager.userAddresses[0]);
    }
  }

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
                      'Hello, ',
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      DataManager.mPrefManager.getName().split(" ").first + '!',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Row(
                    children: [
                      Text(
                        'Delivering to ',
                        style: TextStyle(fontSize: 14),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: (DataManager.userAddresses != null &&
                                DataManager.userAddresses.length > 0)
                            ? DropdownButton(
                                value: currAddress,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF00af87),
                                ),
                                iconSize: 25,
                                underline: SizedBox(),
                                onChanged: selectedAddressChanged,
                                items: DataManager.userAddresses
                                    .map((cUserAddress) {
                                  return DropdownMenuItem<UserAddressesClass>(
                                    value: cUserAddress,
                                    child: Text(
                                      (cUserAddress.locationData.name +
                                                      ', ' +
                                                      cUserAddress
                                                          .buildingNumber)
                                                  .length >
                                              27
                                          ? (cUserAddress.locationData.name +
                                                      ', ' +
                                                      cUserAddress
                                                          .buildingNumber)
                                                  .substring(0, 27) +
                                              ".."
                                          : (cUserAddress.locationData.name +
                                              ', ' +
                                              cUserAddress.buildingNumber),
                                      style: TextStyle(
                                        color: Color(0xFF00af87),
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SubmitAddressScreen(
                                            addedAddress);
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Add Address',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF00af87),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Color(0xFF00af87),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: FadeInImage(
                    image: NetworkImage(DataManager.mainMenuBanner),
                    placeholder: AssetImage(
                      "assets/images/holders/banner_holder.png",
                    ),
                  ),
                ),
                mainMenuCategories(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
