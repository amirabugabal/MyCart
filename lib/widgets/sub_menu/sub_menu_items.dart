import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/sub_menu/sub_menu_item.dart';
import 'package:flutter/material.dart';

Widget subMenuItems(BuildContext mContext) {
  int itemsLength = DataManager.subMenuItems.length;
  return Column(
    children: [
      for (int i = 0; i < itemsLength; i += 2)
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              subMenuItem(mContext, DataManager.subMenuItems[i]),
              SizedBox(
                width: 10,
              ),
              if (i + 1 < itemsLength)
                subMenuItem(mContext, DataManager.subMenuItems[i + 1])
              else
                Padding(
                  padding: EdgeInsets.only(
                    right: (MediaQuery.of(mContext).size.width - 70) / 2,
                  ),
                ),
            ],
          ),
        ),
    ],
  );
}
