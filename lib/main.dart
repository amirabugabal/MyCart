import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mycart/screens/admin/submit_category.dart';
import 'package:mycart/screens/admin/submit_location.dart';
import 'package:mycart/screens/admin/submit_main_menu_item.dart';
import 'package:mycart/screens/admin/submit_sub_menu_item.dart';
import 'package:mycart/screens/admin/view_messages.dart';
import 'package:mycart/screens/contactus_screen.dart';
import 'package:mycart/screens/offers_screen.dart';
import 'package:mycart/screens/checkout.dart';
import 'package:mycart/screens/my_cart.dart';
import 'package:mycart/screens/drawer_screen.dart';
import 'package:mycart/screens/forgot_password.dart';
import 'package:mycart/screens/get_started.dart';
import 'package:mycart/screens/main_menu.dart';
import 'package:mycart/screens/order_placed.dart';
import 'package:mycart/screens/profile.dart';
import 'package:mycart/screens/settings.dart';
import 'package:mycart/screens/sign_in.dart';
import 'package:mycart/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:mycart/services/data_manager.dart';
import './screens/splash_screen.dart';
import 'screens/about.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void iniNotifications() async {
    await Firebase.initializeApp();
    AwesomeNotifications().initialize('resource://drawable/logo', [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'My Cart',
          channelDescription: 'My Cart Notifications',
          defaultColor: Color(0xFF00af87),
          ledColor: Colors.green)
    ]);
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      showBasicNotification(
          message["notification"]["title"], message["notification"]["body"]);
    }, onResume: (Map<String, dynamic> message) async {
      showBasicNotification(
          message["notification"]["title"], message["notification"]["body"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      showBasicNotification(
          message["notification"]["title"], message["notification"]["body"]);
    });
  }

  Future<void> showBasicNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 1,
      channelKey: 'basic_channel',
      title: title,
      body: body,
    ));
  }

  @override
  Widget build(BuildContext context) {
    DataManager.mPrefManager.getIsNotifications(iniNotifications);
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
      title: 'My Cart',
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: Colors.white,
        accentColor: Color(0xFF00af87),

        // Define the default font family.
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        buttonTheme: ButtonThemeData(buttonColor: Colors.white),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      darkTheme: (ThemeData(brightness: Brightness.dark)),
      //home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreen(),
        GetStartedScreen.routeName: (ctx) => GetStartedScreen(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
        MainMenuScreen.routeName: (ctx) => MainMenuScreen(),
        OffersScreen.routeName: (ctx) => OffersScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        MyCartScreen.routeName: (ctx) => MyCartScreen(),
        OrderPlacedScreen.routeName: (ctx) => OrderPlacedScreen(),
        DrawerScreen.routeName: (ctx) => DrawerScreen(),
        CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
        ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
        SubmitCategory.routeName: (ctx) => SubmitCategory(),
        SubmitLocation.routeName: (ctx) => SubmitLocation(),
        SubmitSubItem.routeName: (ctx) => SubmitSubItem(),
        SubmitMainItem.routeName: (ctx) => SubmitMainItem(),
        AboutUs.routeName: (ctx) => AboutUs(),
        Settings.routeName: (ctx) => Settings(),
        MyMessagesScreen.routeName: (ctx) => MyMessagesScreen(),
      },
    );
  }
}
