import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycart/models/addresses/delivery_locations.dart';
import 'package:mycart/services/data_manager.dart';

class SubmitLocation extends StatefulWidget {
  static const routeName = '/submitLocation';

  Function callBackFunction;
  DeliveryLocationsClass cLocation;

  SubmitLocation([this.callBackFunction, this.cLocation]);

  @override
  _SubmitLocationState createState() => _SubmitLocationState();
}

class _SubmitLocationState extends State<SubmitLocation> {
  final _formKey = GlobalKey<FormState>();

  final locationNameController = TextEditingController();
  final locationTimeController = TextEditingController();
  final locationFeesController = TextEditingController();

  @override
  void initState() {
    if (widget.cLocation != null) {
      locationNameController.text = widget.cLocation.name.toString();
      locationTimeController.text = widget.cLocation.deliveryTime.toString();
      locationFeesController.text = widget.cLocation.deliveryFees.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    locationNameController.dispose();
    locationTimeController.dispose();
    locationFeesController.dispose();
    super.dispose();
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
            widget.cLocation == null ? 'Add Location' : 'Update Location',
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
              Image(
                image: AssetImage('assets/images/loc.png'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: locationNameController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          isDense: true,
                          hintText: 'Location Name',
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
                        controller: locationTimeController,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          isDense: true,
                          hintText: 'Time',
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
                            return 'Please enter a valid period of time';
                          }
                          if (int.tryParse(value) <= 0) {
                            return 'Please enter a Time bigger than Zero, In Minutes';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: locationFeesController,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          isDense: true,
                          hintText: 'Fees',
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
                            return 'Please enter a valid Transportation Fee';
                          }
                          if (int.tryParse(value) <= 0) {
                            return 'Please enter a price bigger than Zero';
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
                                widget.cLocation == null
                                    ? 'Add Location'
                                    : 'Update Location',
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
                              var locName = locationNameController.text;
                              var locTime =
                                  int.parse(locationTimeController.text);
                              var locFees =
                                  double.parse(locationFeesController.text);
                              DataManager.submitLocation(
                                locName,
                                locTime,
                                locFees,
                                widget.cLocation != null
                                    ? widget.cLocation.id
                                    : "",
                              ).then((value) {
                                Navigator.of(context).pop();
                                if (widget.callBackFunction != null) {
                                  widget.callBackFunction();
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
