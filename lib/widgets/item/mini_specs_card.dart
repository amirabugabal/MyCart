import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Widget miniSpecsCard(String title, int value) {
  return Padding(
    padding: EdgeInsets.only(right: 0),
    child: Container(
      width: 82,
      decoration: BoxDecoration(
        color: SchedulerBinding.instance.window.platformBrightness ==
                Brightness.dark
            ? Color(0xFF444444)
            : Color(0xFFf0f0f0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF00af87),
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
