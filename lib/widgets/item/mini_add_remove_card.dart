import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Widget miniAddRemoveCard(
    double size, int iniValue, Function addCallBack, Function removeCallBack) {
  return Padding(
    padding: EdgeInsets.only(right: 0),
    child: Row(
      children: [
        Container(
          width: 50 * size,
          decoration: BoxDecoration(
            color: iniValue > 0
                ? Colors.red[200]
                : SchedulerBinding.instance.window.platformBrightness ==
                        Brightness.dark
                    ? Color(0xFF444444)
                    : Color(0xFFf0f0f0),
            borderRadius: BorderRadius.circular(20 * size),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20 * size),
            onTap: removeCallBack,
            child: Padding(
              padding: EdgeInsets.all(12 * size),
              child: Icon(
                iniValue > 1 ? Icons.remove : Icons.delete_outline,
                size: 24 * size,
                color: iniValue > 0 ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20 * size, right: 20 * size),
          child: Text(
            iniValue.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          width: 50 * size,
          decoration: BoxDecoration(
            color: SchedulerBinding.instance.window.platformBrightness ==
                    Brightness.dark
                ? Color(0xFF444444)
                : Color(0xFFf0f0f0),
            borderRadius: BorderRadius.circular(20 * size),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20 * size),
            onTap: addCallBack,
            child: Padding(
              padding: EdgeInsets.all(12 * size),
              child: Icon(
                Icons.add,
                size: 24 * size,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
