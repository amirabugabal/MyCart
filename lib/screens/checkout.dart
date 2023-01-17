import 'package:mycart/models/addresses/user_addresses.dart';
import 'package:mycart/screens/order_placed.dart';
import 'package:mycart/screens/profile.dart';
import 'package:mycart/services/cart_manager.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/cart/payment_summary.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutScreen extends StatefulWidget {
  static const appBarTitle = 'Checkout';
  static const routeName = '/checkout';

  @override
  CheckoutScreenState createState() {
    return CheckoutScreenState();
  }
}

class CheckoutScreenState extends State<CheckoutScreen> {
  UserAddressesClass currAddress;
  double subtotal = CartManager.subtotal;
  double deliveryFees = CartManager.deliveryFees;

  final promoCodeController = TextEditingController();
  bool isPromoApplied = false;

  String selectedRadioItem = 'COD (Cash on Delivery)';
  int selectedRadioId = 1;

  void selectedAddressChanged(UserAddressesClass newAddress) {
    //DataManager.mPrefManager.setSelectedAddress(newAddress.id);
    setState(() {
      currAddress = newAddress;
    });
  }

  void applyPromoCode() {
    setState(() {
      if (isPromoApplied) {
        CartManager.discount = 0;
        CartManager.promocode = '';
        isPromoApplied = false;
      } else {
        if (promoCodeController.text.toLowerCase() == 'FRESH25'.toLowerCase()) {
          CartManager.discount = 25;
          CartManager.promocode = 'FRESH25';
          isPromoApplied = true;
        } else if (promoCodeController.text.toLowerCase() ==
            'FRESH50'.toLowerCase()) {
          CartManager.discount = 50;
          CartManager.promocode = 'FRESH50';
          isPromoApplied = true;
        } else {
          CartManager.discount = 0;
          CartManager.promocode = 'FRESH25';
          isPromoApplied = false;
        }
      }
    });
  }

  void applyPromoCodeChecker() {
    if (!isPromoApplied && promoCodeController.text != '') {
      applyPromoCode();
    }
  }

  @override
  void initState() {
    for (UserAddressesClass i in DataManager.userAddresses) {
      if (i.id == DataManager.mPrefManager.getSelectedAddress()) {
        currAddress = i;
      }
    }
    if (CartManager.promocode != "" && CartManager.discount != 0) {
      isPromoApplied = true;
      promoCodeController.text = CartManager.promocode;
    }
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
            'Checkout',
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
            Padding(
              padding:
                  EdgeInsets.only(top: 22, left: 30, right: 30, bottom: 22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Address',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProfileScreen.routeName,
                          ); // Edit Address Screen
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: DropdownButton(
                            value: currAddress,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF00af87),
                            ),
                            iconSize: 25,
                            underline: SizedBox(),
                            onChanged: selectedAddressChanged,
                            items:
                                DataManager.userAddresses.map((cUserAddress) {
                              return DropdownMenuItem<UserAddressesClass>(
                                value: cUserAddress,
                                child: Text(
                                  (cUserAddress.locationData.name).length > 27
                                      ? (cUserAddress.locationData.name)
                                              .substring(0, 27) +
                                          ".."
                                      : (cUserAddress.locationData.name),
                                  style: TextStyle(
                                    color: Color(0xFF00af87),
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 0,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15.0),
                              onTap: () {
                                //Navigator.pushNamed(context, MainMenuScreen.routeName);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Color(0xFF00af87),
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          currAddress.locationData.name,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.home_work_outlined,
                                          color: Color(0xFF00af87),
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          currAddress.streetName +
                                              ', ' +
                                              currAddress.buildingNumber +
                                              ', ' +
                                              currAddress.floorNumber
                                                  .toString() +
                                              ', ' +
                                              currAddress.apartmentNumber
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          color: Color(0xFF00af87),
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          currAddress.phoneNumber,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.delivery_dining,
                                          color: Color(0xFF00af87),
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          currAddress.locationData.deliveryTime
                                                  .toString() +
                                              " minutes",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 0,
                            child: Column(
                              children: [
                                RadioListTile(
                                  title: Text('COD (Cash on Delivery)'),
                                  groupValue: selectedRadioId,
                                  value: 1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedRadioItem =
                                          'COD (Cash on Delivery)';
                                      selectedRadioId = 1;
                                    });
                                  },
                                ),
                                RadioListTile(
                                  toggleable: false,
                                  title: Text('Credit Card'),
                                  groupValue: selectedRadioId,
                                  value: 2,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedRadioItem = 'Credit Card';
                                      selectedRadioId = 2;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: TextFormField(
                      readOnly: isPromoApplied,
                      onEditingComplete: applyPromoCodeChecker,
                      controller: promoCodeController,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Promo Code',
                        hintStyle: new TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        suffixIcon: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: applyPromoCode,
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: isPromoApplied
                                ? Icon(
                                    Icons.verified_outlined,
                                    color: Color(0xFF00af87),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.confirmation_num_outlined,
                                        color: Color(0xFF00af87),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Apply',
                                        style: TextStyle(
                                          color: Color(0xFF00af87),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  paymentSummary(subtotal, deliveryFees, false),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
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
                          constraints: const BoxConstraints(
                              minWidth: 88.0, minHeight: 55),
                          alignment: Alignment.center,
                          child: const Text(
                            'Place Order',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        DataManager.placeOrder().then((value) {
                          if (value) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed(
                                OrderPlacedScreen.routeName);
                          } else {
                            Fluttertoast.showToast(
                              msg: "An error occurred, please try again later.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
