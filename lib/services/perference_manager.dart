import 'package:mycart/models/addresses/user_addresses.dart';
import 'package:mycart/services/cart_manager.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  String id = "";
  var name = "Guest";
  var phone = "";
  var email = "";
  var password = "";
  var lang = 0;
  var pref;
  String selectedAddress = "";
  String type = '';
  int isNotifications = 1;

  PrefManager() {
    //loadDataFromLocalMemory();
  }

  Future<bool> setLoggedInData(String id, String name, String phone,
      String email, String password, String type) async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    this.id = id;
    this.name = name;
    this.phone = phone;
    this.email = email;
    this.password = password;
    this.type = type;
    pref.setString("id", id);
    pref.setString("name", name);
    pref.setString("phone", phone);
    pref.setString("email", email);
    pref.setString("password", password);
    pref.setString("type", type);
    print("Saved! - {$id} - {$name} - {$email}");
    return true;
  }

  Future<void> loadDataFromLocalMemory() async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    lang = pref.getInt("lang") ?? lang;
    id = pref.getString("id") ?? id;
    name = pref.getString("name") ?? name;
    phone = pref.getString("phone") ?? phone;
    email = pref.getString("email") ?? email;
    password = pref.getString("password") ?? password;
    selectedAddress = pref.getString("address") ?? selectedAddress;
    isNotifications = pref.getInt("isNotifications") ?? isNotifications;
    type = pref.getString("type") ?? type;
    print(
        "Loaded - {$id} - {$name} - {$email} - {Lang: $lang} - {Add: $selectedAddress}");
  }

  Future<void> saveDataToLocalMemory() async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    pref.setString("id", id);
    pref.setString("name", name);
    pref.setString("phone", phone);
    pref.setString("email", email);
    pref.setString("password", password);
    pref.setString("address", selectedAddress);
    pref.setString("type", type);
    pref.setInt("isNotifications", isNotifications);
    print("Saved! - {$id} - {$name} - {$email} - {$selectedAddress}");
  }

  bool setId(String id) {
    this.id = id;
    return true;
  }

  bool setName(String name) {
    this.name = name;
    return true;
  }

  bool setPhone(String phone) {
    this.phone = phone;
    return true;
  }

  bool setEmail(String email) {
    this.email = email;
    return true;
  }

  bool setPassword(String password) {
    this.password = password;
    return true;
  }

  bool setType(String type) {
    this.type = type;
    return true;
  }

  String getId() {
    return id;
  }

  String getName() {
    return name;
  }

  String getPhone() {
    return phone;
  }

  String getEmail() {
    return email;
  }

  String getType() {
    return type;
  }

  bool isLoggedIn() {
    if (id.toString() != "") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logOut() async {
    this.id = "";
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    pref.setString("id", "");
    pref.setString("name", "Guest");
    pref.setString("phone", "");
    pref.setString("email", "");
    pref.setString("password", "");
    pref.setString("address", "");
  }

  Future<void> setLang(int lang) async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    this.lang = lang;
    pref.setInt("lang", lang);
  }

  int getLang() {
    return this.lang;
  }

  bool isLangSet() {
    return (lang != 0);
  }

  Future<void> setSelectedAddress(String address) async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    this.selectedAddress = address;
    pref.setString("address", address);
    updateDeliveryFeesAndTime();
  }

  String getSelectedAddress() {
    return this.selectedAddress;
  }

  void updateDeliveryFeesAndTime() {
    if (selectedAddress != "") {
      for (UserAddressesClass i in DataManager.userAddresses) {
        if (i.id == DataManager.mPrefManager.getSelectedAddress()) {
          CartManager.deliveryFees = i.locationData.deliveryFees;
          CartManager.deliveryTime = i.locationData.deliveryTime;
        }
      }
    } else {
      CartManager.deliveryFees = 0;
      CartManager.deliveryTime = 0;
    }
  }

  Future<void> setIsNotifications(int isNotifications) async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    this.isNotifications = isNotifications;
    pref.setInt("isNotifications", isNotifications);
    print("Subscribe to notifications is set to " + isNotifications.toString());
  }

  Future<int> getIsNotifications([Function callBack]) async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    isNotifications = pref.getInt("isNotifications") ?? isNotifications;
    if (callBack != null && isNotifications == 1) {
      callBack();
    }
    return isNotifications;
  }
}
