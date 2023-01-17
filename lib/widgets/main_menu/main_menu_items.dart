import 'package:mycart/models/main_menu/main_menu_item.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/main_menu/main_menu_item.dart';
import 'package:flutter/material.dart';

Widget mainMenuItems(BuildContext mContext, String categoryId) {
  List categoryItems = new List();
  for (MainMenuItemClass i in DataManager.mainMenuItems) {
    if (i.categoryId == categoryId) {
      categoryItems.add(i);
    }
  }
  int itemsLength = categoryItems.length;
  return Column(
    children: [
      for (int i = 0; i < itemsLength; i += 3)
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            children: [
              mainMenuItem(mContext, categoryItems[i]),
              SizedBox(
                width: 10,
              ),
              if (i + 1 < itemsLength)
                mainMenuItem(mContext, categoryItems[i + 1])
              else
                Padding(
                  padding: EdgeInsets.only(
                    right: (MediaQuery.of(mContext).size.width - 80) / 3,
                  ),
                ),
              SizedBox(
                width: 10,
              ),
              if (i + 2 < itemsLength)
                mainMenuItem(mContext, categoryItems[i + 2])
              else
                Padding(
                  padding: EdgeInsets.only(
                    right: (MediaQuery.of(mContext).size.width - 80) / 3,
                  ),
                ),
            ],
          ),
        ),
    ],
  );
}
