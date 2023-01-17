import 'package:mycart/services/cart_manager.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:mycart/widgets/cart/dashed_separator.dart';

Widget paymentSummary(double subtotal, double deliveryFees, bool isCart) {
  double discount = CartManager.discount;
  bool isDiscount = discount != 0;
  double total = CartManager.getTotalPrice();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isCart
          ? DashedSeparator(
              color: Colors.grey,
            )
          : SizedBox(),
      isCart
          ? Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 15),
              child: Container(
                child: Text(
                  'Payment Summary',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            )
          : SizedBox(),
      Padding(
        padding: isCart
            ? EdgeInsets.only(left: 70, right: 30, top: 10, bottom: 10)
            : EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      (subtotal).toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'EGP',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            isDiscount
                ? Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Promocode',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              (-discount).toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              'EGP',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            (DataManager.mPrefManager.getSelectedAddress() != 0 &&
                    DataManager.userAddresses != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fees',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            (deliveryFees).toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'EGP',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
      isCart
          ? Divider(
              color: Colors.grey,
            )
          : SizedBox(),
      Padding(
        padding: isCart
            ? EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10)
            : EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Text(
                  (total).toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF00af87),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'EGP',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF00af87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
