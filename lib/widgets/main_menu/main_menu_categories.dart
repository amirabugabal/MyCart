import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:mycart/models/main_menu/main_menu_category.dart';
import 'package:mycart/screens/admin/submit_category.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/main_menu/main_menu_items.dart';
import 'package:flutter/material.dart';

Widget mainMenuCategories(BuildContext mContext) {
  return Column(
    children: [
      for (MainMenuCategoryClass i in DataManager.mainMenuCategories)
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    i.getName(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DataManager.mPrefManager.getType() == 'admin'
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  mContext,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SubmitCategory(null, i);
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF00af87),
                                    ),
                                  ),
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF00af87),
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (await confirm(
                                  mContext,
                                  title: Text(
                                    'Delete Address',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  content: Text(
                                      'Are you sure that you want to delete this category?'),
                                  textOK: Text('Yes'),
                                  textCancel: Text('No'),
                                )) {
                                  DataManager.deleteCategory(i.id);
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFd86464),
                                    ),
                                  ),
                                  Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFd86464),
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
            mainMenuItems(mContext, i.getId()),
          ],
        ),
    ],
  );
}
