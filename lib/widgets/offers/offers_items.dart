import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/sub_menu/sub_menu_item.dart';
import 'package:flutter/material.dart';

Widget offersItems(BuildContext mContext) {
  int itemsLength = 0;
  if (DataManager.offersItems != null && DataManager.offersItems.length > 0) {
    itemsLength = DataManager.offersItems.length;
  }
  return itemsLength != 0
      ? Column(
          children: [
            for (int i = 0; i < itemsLength; i += 2)
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    subMenuItem(mContext, DataManager.offersItems[i]),
                    SizedBox(
                      width: 10,
                    ),
                    if (i + 1 < itemsLength)
                      subMenuItem(mContext, DataManager.offersItems[i + 1])
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
        )
      : Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "There is no offers now.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        );
}
