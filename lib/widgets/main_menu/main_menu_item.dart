import 'package:mycart/screens/item.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget mainMenuItem(BuildContext mContext, mItem) {
  return Expanded(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 15,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          return Navigator.push(
            mContext,
            MaterialPageRoute(
              builder: (context) {
                return ItemScreen(mItem);
              },
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(mItem[3]),
                placeholder: AssetImage(
                  "assets/images/holders/main_menu_item_holder.png",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 7),
                child: AutoSizeText(
                  mItem[2],
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
