import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../src/locations.dart' as locations;

class AboutUs extends StatefulWidget {
  static const routeName = '/about-us';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<AboutUs> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    'About Us',
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
      body: ListView(
        children: [
          SizedBox(height: 25),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Text(
                  'My Cart is an E-Commerce Application that is multi-platform, we offer all kinds of items and categories for you to choose from.  ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.all(20),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Contact Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.all(20),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                  '+01066625846\n+01119523790\n+01114775700\nadmin@mycart.org',
                  style: TextStyle(fontSize: 15)),
              margin: EdgeInsets.only(left: 20),
            ),
          ),
          SizedBox(height: 40),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: const LatLng(26.8206, 30.8025),
                zoom: 5,
              ),
              markers: _markers.values.toSet(),
            ),
          ),
        ],
      ),
    ));
  }
}
