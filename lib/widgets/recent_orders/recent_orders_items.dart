import 'package:mycart/models/main/main_values.dart';
import 'package:mycart/models/recent_orders/recent_orders.dart';
import 'package:mycart/models/recent_orders/recent_orders_item.dart';
import 'package:mycart/screens/my_cart.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/recent_orders/recent_orders_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentOrdersItemsWidget extends StatefulWidget {
  BuildContext mContext;
  RecentOrdersClass oItem;
  Function toggleIsLoading;
  RecentOrdersItemsWidget(BuildContext mContext, RecentOrdersClass oItem,
      Function toggleIsLoading) {
    this.mContext = mContext;
    this.oItem = oItem;
    this.toggleIsLoading = toggleIsLoading;
  }

  @override
  _RecentOrdersItemsWidgetState createState() =>
      _RecentOrdersItemsWidgetState();
}

class _RecentOrdersItemsWidgetState extends State<RecentOrdersItemsWidget> {
  bool isExpanded = false;

  void showDetails() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width - 232;
    RecentOrdersClass oItem = widget.oItem;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 15,
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: showDetails,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                DateFormat('dd/MM/yy - HH:mm a')
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        oItem.getTime() * 1000))
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF00af87),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "#" + oItem.getId().toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          isExpanded
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery Address",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          Row(
                            children: [
                              Icon(
                                Icons.home_work_outlined,
                                color: Color(0xFF00af87),
                                size: 16,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: mWidth,
                                child: Text(
                                  oItem.deliveryAddressDetails,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          isExpanded
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          color: Color(0xFF00af87),
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          oItem.deliveryAddressPhoneNumber,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Order Details",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    for (RecentOrdersItemClass i in oItem.items)
                                      recentOrdersItem(context, i),
                                    oItem.orderNote != ""
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Order Notes",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit_outlined,
                                                    color: Color(0xFF00af87),
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: mWidth,
                                                    child: Text(
                                                      oItem.orderNote,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                )
                              : Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.list_alt,
                                        color: Color(0xFF00af87),
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(oItem
                                              .getTotalOrderItems()
                                              .toString() +
                                          " x items"),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                oItem.getTotalPrice().toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00af87),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'EGP',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00af87),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          MainValues.orderStatus[oItem.getStatus()],
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF00af87),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
