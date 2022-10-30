import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  static const appBarTitle = "Order Placed";
  static const routeName = '/order_placed';

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
            'Order Placed',
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
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 32, left: 30, right: 30, bottom: 32),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child:
                          Image.asset('assets/images/other_icons/bike_lg.png'),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thanks for your order',
                            style: TextStyle(
                              fontSize: 18,
                            ), //Needs Simi-bold weight
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8, bottom: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your order will be delivered in 40 min',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
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
                    constraints:
                        const BoxConstraints(minWidth: 88.0, minHeight: 55),
                    alignment: Alignment.center,
                    child: const Text(
                      'See your Previous Orders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onPressed: () {
                  print("Prev.");
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
