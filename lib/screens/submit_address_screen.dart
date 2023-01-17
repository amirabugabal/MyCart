import 'package:mycart/models/addresses/delivery_locations.dart';
import 'package:mycart/models/addresses/user_addresses.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:flutter/material.dart';

class SubmitAddressScreen extends StatefulWidget {
  Function callBackFunction;
  UserAddressesClass cUserAddress;

  SubmitAddressScreen(this.callBackFunction, [this.cUserAddress]);

  @override
  SubmitAddressScreenState createState() {
    return SubmitAddressScreenState();
  }
}

class SubmitAddressScreenState extends State<SubmitAddressScreen> {
  DeliveryLocationsClass currLocation = DataManager.deliveryLocations[0];
  final _formKey = GlobalKey<FormState>();
  final streetNameController = TextEditingController();
  final buildingNumberController = TextEditingController();
  final floorNumberController = TextEditingController();
  final apartmentNumberController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    streetNameController.dispose();
    buildingNumberController.dispose();
    floorNumberController.dispose();
    apartmentNumberController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void locationChanged(DeliveryLocationsClass newLocation) {
    setState(() {
      currLocation = newLocation;
    });
  }

  @override
  void initState() {
    if (widget.cUserAddress != null) {
      print('existing add.');
      currLocation = widget.cUserAddress.locationData;
      streetNameController.text = widget.cUserAddress.streetName;
      buildingNumberController.text = widget.cUserAddress.buildingNumber;
      floorNumberController.text = widget.cUserAddress.floorNumber.toString();
      apartmentNumberController.text =
          widget.cUserAddress.apartmentNumber.toString();
      phoneNumberController.text = widget.cUserAddress.phoneNumber.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          brightness: Brightness.dark,
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF00d466),
                  Color(0xFF00af87),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          automaticallyImplyLeading: false,
          leadingWidth: 65,
          title: Text(
            widget.cUserAddress == null ? 'Add Address' : 'Update Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 15, right: 9, top: 9, bottom: 9),
            child: IconButton(
              icon: Image.asset('assets/images/other_icons/back_arrow.png'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: 30,
              bottom: 30,
            ),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? Color(0xFF444444)
                            : Color(0xFFf0f0f0),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            buttonTheme: ButtonTheme.of(context).copyWith(
                          alignedDropdown: true,
                        )),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<DeliveryLocationsClass>(
                              onChanged: locationChanged,
                              value: currLocation,
                              items: DataManager.deliveryLocations.map((value) {
                                return DropdownMenuItem<DeliveryLocationsClass>(
                                  value: value,
                                  child: Text(
                                    value.name,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: streetNameController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          isDense: true,
                          hintText: 'Street Name',
                          hintStyle: new TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your street name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: buildingNumberController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          isDense: true,
                          hintText: 'Building Number',
                          hintStyle: new TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your building number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: floorNumberController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Floor Number',
                          hintStyle: new TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your floor number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: apartmentNumberController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Apartment Number',
                          hintStyle: new TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your apartment number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: phoneNumberController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Phone Number',
                          hintStyle: new TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length < 11) {
                            return 'Phone number must be 11 number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF00d466),
                                  Color(0xFF00af87),
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0, minHeight: 55),
                              alignment: Alignment.center,
                              child: Text(
                                widget.cUserAddress == null
                                    ? 'Add Address'
                                    : 'Update Address',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              var locationId = currLocation.id;
                              var streetName = streetNameController.text;
                              var buildingNumber =
                                  buildingNumberController.text;
                              var floorNumber = floorNumberController.text;
                              var apartmentNumber =
                                  apartmentNumberController.text;
                              var phoneNumber = phoneNumberController.text;
                              DataManager.submitAddress(
                                locationId,
                                streetName,
                                buildingNumber,
                                floorNumber,
                                apartmentNumber,
                                phoneNumber,
                                widget.cUserAddress != null
                                    ? widget.cUserAddress.id
                                    : "",
                              ).then((response) {
                                if (response) {
                                  Navigator.pop(context);
                                  DataManager.iniUserAddresses(
                                      widget.callBackFunction);
                                }
                              });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
