import 'package:mycart/models/recent_orders/recent_orders_item.dart';
import 'package:flutter/material.dart';

Widget recentOrdersItem(BuildContext mContext, RecentOrdersItemClass oItem) {
  double mWidth = MediaQuery.of(mContext).size.width - 232;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          Text(
            oItem.getQTY().toString() + ' x ',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF00af87),
            ),
          ),
          Container(
            width: mWidth,
            child: Text(
              oItem.getItemName(),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
