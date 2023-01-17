import 'package:flutter/material.dart';

Widget cartEmpty(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 32, left: 30, right: 30, bottom: 32),
    child: Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('assets/images/other_icons/cart_lg.png'),
              ),
              Container(
                padding: EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Cart is Empty',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 25),
                      child: Text(
                        'Looks like you haven\'t added anything to your cart yet.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 55),
              alignment: Alignment.center,
              child: const Text(
                'Check Main Menu',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onPressed: () {
            print("MainMenu");
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
