import 'package:flutter/foundation.dart';

class Message with ChangeNotifier {
  String message;
  String userId;

  Message(String mes, String id){
    this.message = mes;
    this.userId = id;
  }
}