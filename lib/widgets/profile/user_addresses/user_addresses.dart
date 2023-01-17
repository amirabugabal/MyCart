import 'package:mycart/models/addresses/user_addresses.dart';
import 'package:mycart/screens/submit_address_screen.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

class UserAddressesWidget extends StatefulWidget {
  BuildContext mContext;
  UserAddressesClass oAddress;
  Function callBackFunction;
  UserAddressesWidget(BuildContext mContext, UserAddressesClass oAddress,
      Function callBackFunction) {
    this.mContext = mContext;
    this.oAddress = oAddress;
    this.callBackFunction = callBackFunction;
  }

  @override
  _UserAddressesWidgetState createState() => _UserAddressesWidgetState();
}

class _UserAddressesWidgetState extends State<UserAddressesWidget> {
  bool isExpanded = false;

  void showDetails() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserAddressesClass oAddress = widget.oAddress;
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
                  child: Column(
                    children: <Widget>[
                      isExpanded
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return SubmitAddressScreen(
                                                    widget.callBackFunction,
                                                    oAddress);
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
                                            context,
                                            title: Text(
                                              'Delete Address',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            content: Text(
                                                'Are you sure that you want to delete this address?'),
                                            textOK: Text('Yes'),
                                            textCancel: Text('No'),
                                          )) {
                                            DataManager.deleteAddress(
                                                    oAddress.id)
                                                .then(
                                              (value) {
                                                DataManager.iniUserAddresses(
                                                    widget.callBackFunction);
                                              },
                                            );
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
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF00af87),
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            oAddress.locationData.name,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
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
                          Text(
                            oAddress.streetName +
                                ', ' +
                                oAddress.buildingNumber +
                                ', ' +
                                oAddress.floorNumber.toString() +
                                ', ' +
                                oAddress.apartmentNumber.toString(),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      isExpanded
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
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
                                      oAddress.phoneNumber,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.delivery_dining,
                                      color: Color(0xFF00af87),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      oAddress.locationData.deliveryTime
                                              .toString() +
                                          " minutes",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : SizedBox(),
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
