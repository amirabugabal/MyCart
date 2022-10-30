import 'package:mycart/screens/checkout.dart';
import 'package:mycart/screens/my_cart.dart';
import 'package:mycart/screens/drawer_screen.dart';
import 'package:mycart/screens/main_menu.dart';
import 'package:mycart/screens/order_placed.dart';
import 'package:mycart/screens/profile.dart';
import 'package:mycart/screens/sign_in.dart';
import 'package:mycart/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:mycart/screens/submit_address_screen.dart';
import './screens/splash_screen.dart';
import 'screens/about.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
      title: 'My Cart',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xFF89CFF0),
        fontFamily: 'Montserrat',
        buttonTheme: ButtonThemeData(buttonColor: Colors.white),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      darkTheme: (ThemeData(brightness: Brightness.dark)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreen(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        MainMenuScreen.routeName: (ctx) => MainMenuScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        MyCartScreen.routeName: (ctx) => MyCartScreen(),
        OrderPlacedScreen.routeName: (ctx) => OrderPlacedScreen(),
        DrawerScreen.routeName: (ctx) => DrawerScreen(),
        CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
        AboutUs.routeName: (ctx) => AboutUs(),
        SubmitAddressScreen.routeName: (ctx) => SubmitAddressScreen(),
      },
    );
  }
}
