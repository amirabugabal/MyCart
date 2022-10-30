import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  static const appBarTitle = 'Checkout';
  static const routeName = '/checkout';

  @override
  CheckoutScreenState createState() {
    return CheckoutScreenState();
  }
}

class CheckoutScreenState extends State<CheckoutScreen> {

  final promoCodeController = TextEditingController();

  String selectedRadioItem = 'COD (Cash on Delivery)';
  int selectedRadioId = 1;

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
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.confirmation_num_outlined,
                                        color: Color(0xFF89CFF0),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Apply',
                                        style: TextStyle(
                                          color: Color(0xFF89CFF0),
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
                              Color(0xFF89CFF0),
                              Color(0xFF0047AB),
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
                      onPressed: () {},
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
