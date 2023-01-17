import 'package:mycart/screens/checkout.dart';
import 'package:mycart/screens/submit_address_screen.dart';
import 'package:mycart/services/cart_manager.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/cart/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:mycart/widgets/cart/cart_empty.dart';
import 'package:mycart/widgets/cart/payment_summary.dart';

class MyCartScreen extends StatefulWidget {
  static const appBarTitle = "My Cart";
  static const routeName = '/my-cart';
  @override
  MyCartScreenState createState() {
    return MyCartScreenState();
  }
}

class MyCartScreenState extends State<MyCartScreen> {
  final noteController = TextEditingController();
  List mCart = CartManager.mCart;
  bool isCartEmpty = (CartManager.mCart.length == 0);
  double subtotal = CartManager.subtotal;
  double deliveryFees = CartManager.deliveryFees;

  @override
  void initState() {
    noteController.text = CartManager.orderNote;
  }

  void refreshData() {
    setState(() {
      mCart = CartManager.mCart;
      isCartEmpty = (CartManager.mCart.length == 0);
      subtotal = CartManager.subtotal;
      deliveryFees = CartManager.deliveryFees;
    });
  }

  void reCalculate() {
    setState(() {
      subtotal = CartManager.subtotal;
      mCart = CartManager.mCart;
      if (CartManager.mCart.length == 0) {
        isCartEmpty = true;
      }
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
            'My Cart',
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
        body: isCartEmpty
            ? cartEmpty(context)
            : ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 22, bottom: 15),
                        child: Column(
                          children: [
                            Column(children: [
                              for (var i in CartManager.mCart)
                                CartItem(i, reCalculate),
                            ] /*CartManager.myCart
                                  .map(
                                      (item) => new CartItem(item, reCalculate))
                                  .toList(),*/
                                ),
                            Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: TextFormField(
                                controller: noteController,
                                onChanged: (value) =>
                                    CartManager.orderNote = value,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: 'Write a note',
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
                                  prefixIcon: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 10),
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      paymentSummary(subtotal, deliveryFees, true),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 15, bottom: 22),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0, minHeight: 55),
                              alignment: Alignment.center,
                              child: const Text(
                                'Proceed to Checkout',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (DataManager.userAddresses == null ||
                                DataManager.userAddresses.length == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SubmitAddressScreen(refreshData);
                                  },
                                ),
                              );
                            } else {
                              Navigator.of(context)
                                  .pushNamed(CheckoutScreen.routeName);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
