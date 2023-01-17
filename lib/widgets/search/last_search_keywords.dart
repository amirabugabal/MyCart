import 'package:mycart/services/data_manager.dart';
import 'package:flutter/material.dart';

Widget lastSearchKeywords(BuildContext mContext, Function setCurrentSearch) {
  List lastSearchKeywordsReversed =
      DataManager.lastSearchKeywords.reversed.toList();
  return Column(
    children: [
      DataManager.lastSearchKeywords.length != 0
          ? Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Last search keywords",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          : Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Type something to search.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
      SizedBox(
        height: 17,
      ),
      for (String i in lastSearchKeywordsReversed)
        Padding(
          padding: EdgeInsets.only(bottom: 13),
          child: GestureDetector(
            onTap: () {
              setCurrentSearch(i);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    i,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  Icons.call_made_rounded,
                ),
              ],
            ),
          ),
        ),
    ],
  );
}
