import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mycart/models/addresses/delivery_locations.dart';
import 'package:mycart/models/addresses/user_addresses.dart';
import 'package:mycart/models/main_menu/main_menu_category.dart';
import 'package:mycart/models/main_menu/main_menu_item.dart';
import 'package:mycart/models/messages/message.dart';
import 'package:mycart/models/recent_orders/recent_orders.dart';
import 'package:mycart/models/recent_orders/recent_orders_item.dart';
import 'package:mycart/models/sub_menu/sub_menu_item.dart';
import 'package:mycart/services/data_manager.dart';

class FirebaseManager {
  static final Future<FirebaseApp> _future = Firebase.initializeApp();
  static final databaseRef = FirebaseDatabase.instance.reference();
  static const url = 'https://my-cart-94544-default-rtdb.firebaseio.com/data/';

  static Future<List> getDeliveryLocations() async {
    var path = 'delivery_locations.json';
    final List<DeliveryLocationsClass> items = [];
    try {
      final response = await http.get(url + path);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, data) {
        items.add(
          DeliveryLocationsClass(
            key.toString(),
            data["name"].toString(),
            double.parse(data["fees"].toString()),
            int.parse(data['time'].toString()),
          ),
        );
      });
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
    return items;
  }

  static Future<List> getUserAddresses() async {
    var path = 'addresses.json';
    final List<UserAddressesClass> items = [];
    try {
      final response = await http.get(url + path);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData != null) {
        dbData.forEach((key, data) {
          if (data['user_id'] == DataManager.mPrefManager.id &&
              data['is_active'] == 1) {
            items.add(
              UserAddressesClass(
                key.toString(),
                data["user_id"].toString(),
                data["location_id"].toString(),
                data['street_name'].toString(),
                data['building_number'].toString(),
                int.parse(data['floor_number'].toString()),
                int.parse(data['apartment_number'].toString()),
                data['phone_number'].toString(),
              ),
            );
          }
        });
      }
    } on Exception catch (e) {
      print(e.toString());
      //throw (e);
    }
    return items;
  }

  static Future<List> getMainMenuCategories() async {
    var path = 'main_menu_categories.json';
    final List<MainMenuCategoryClass> items = [];
    try {
      final response = await http.get(url + path);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, data) {
        items.add(
            MainMenuCategoryClass(key.toString(), data['name'].toString()));
      });
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
    return items;
  }

  static Future<List> getMainMenuItems() async {
    var path = 'main_menu_items.json';
    final List<MainMenuItemClass> items = [];
    try {
      final response = await http.get(url + path);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, data) {
        if (int.parse(data['is_active'].toString()) == 1) {
          items.add(MainMenuItemClass(
            key.toString(),
            data['category_id'].toString(),
            data['name'].toString(),
            data['image'].toString(),
            (int.parse(data['is_active'].toString()) == 1),
          ));
        }
      });
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
    return items;
  }

  static Future<List> getSubMenuItems(String menuId) async {
    var path = 'sub_menu_items.json';
    final List<SubMenuItemClass> items = [];
    try {
      final response = await http.get(url + path);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, data) {
        if (int.parse(data['is_active'].toString()) == 1 &&
            data['menu_id'].toString() == menuId) {
          items.add(SubMenuItemClass(
            key.toString(),
            data['menu_id'].toString(),
            data['name'].toString(),
            data['description'].toString(),
            data['image'].toString(),
            double.parse(data['price'].toString()),
            int.parse(data['discount'].toString()),
            (int.parse(data['is_active'].toString()) == 1),
          ));
        }
      });
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
    return items;
  }

  static Future<List> getSearchItems(String searchKey) async {
    var path = 'sub_menu_items.json';
    final List<SubMenuItemClass> items = [];
    try {
      final response = await http.get(url + path);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, data) {
        if (int.parse(data['is_active'].toString()) == 1 &&
            data['name'].toString().contains(searchKey)) {
          items.add(SubMenuItemClass(
            key.toString(),
            data['menu_id'].toString(),
            data['name'].toString(),
            data['description'].toString(),
            data['image'].toString(),
            double.parse(data['price'].toString()),
            int.parse(data['discount'].toString()),
            (int.parse(data['is_active'].toString()) == 1),
          ));
        }
      });
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
    return items;
  }

  static Future<List> getRecentOrders() async {
    var path = 'recent_orders.json';
    final List<RecentOrdersClass> items = [];
    String deliveryAddressDetails = "";
    String deliveryAddressPhoneNumber = "";
    try {
      final response = await http.get(url + path);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData != null && dbData.length > 0) {
        dbData.forEach((key, data) async {
          if (data['user_id'].toString() == DataManager.mPrefManager.id) {
            var addressPath =
                'addresses/' + data['delivery_address_id'].toString() + '.json';
            try {
              final responseAddress = await http.get(url + addressPath);
              final List dbAddressData =
                  (json.decode(responseAddress.body) as Map<String, dynamic>)
                      .values
                      .toList();
              deliveryAddressDetails = dbAddressData[5].toString() +
                  ', ' +
                  dbAddressData[2].toString() +
                  ', ' +
                  dbAddressData[0].toString();
              deliveryAddressPhoneNumber = dbAddressData[4].toString();
            } on Exception catch (e) {
              print(e.toString());
              throw (e);
            }
            List items2 = new List();
            for (var i in (data['items'])) {
              List ix = i.values.toList();
              items2.add(RecentOrdersItemClass(
                ix[0].toString(),
                key.toString(),
                ix[0].toString(),
                ix[1].toString(),
                int.parse(ix[3].toString()),
                double.parse(ix[2].toString()),
              ));
            }
            items.add(RecentOrdersClass(
              key.toString(),
              double.parse(data['sub_total'].toString()),
              double.parse(data['delivery_fees'].toString()),
              data['promocode'].toString(),
              double.parse(data['discount'].toString()),
              double.parse(data['total_price'].toString()),
              data['delivery_address_id'].toString(),
              deliveryAddressDetails,
              deliveryAddressPhoneNumber,
              data['order_note'].toString(),
              int.parse(data['status'].toString()),
              int.parse(data['time'].toString()),
              items2.toList(),
            ));
          }
        });
      }
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
    return items;
  }

  static Future<bool> submitAddress(locationId, streetName, buildingNumber,
      floorNumber, apartmentNumber, phoneNumber,
      [String addressId = ""]) async {
    try {
      var dbRef2 = databaseRef.child('data').child('addresses');
      if (addressId == "") {
        dbRef2 = dbRef2.push();
      } else {
        dbRef2 = dbRef2.child(addressId.toString());
      }
      await dbRef2.set({
        'user_id': DataManager.mPrefManager.getId().toString(),
        'location_id': locationId.toString(),
        'street_name': streetName,
        'building_number': buildingNumber,
        'floor_number': floorNumber.toString(),
        'apartment_number': apartmentNumber.toString(),
        'phone_number': phoneNumber.toString(),
        'is_active': 1
      }).then((value) {
        if (locationId == "") {
          Fluttertoast.showToast(
            msg: "Address is successfully added.",
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Address is successfully updated.",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      });
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> deleteAddress(addressId) async {
    try {
      await databaseRef
          .child('data')
          .child('addresses')
          .child(addressId)
          .child('is_active')
          .set(0);
      Fluttertoast.showToast(
        msg: "Address is successfully deleted.",
        toastLength: Toast.LENGTH_LONG,
      );
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> placeOrder(myOrder) async {
    try {
      var dbRef2 = databaseRef.child('data').child('recent_orders');
      await dbRef2.push().set(myOrder);
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<List> getOffersItems() async {
    var path = 'sub_menu_items.json';
    final List<SubMenuItemClass> items = [];
    try {
      final response = await http.get(url + path);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, data) {
        if (int.parse(data['is_active'].toString()) == 1 &&
            data['discount'].toString() != "0") {
          items.add(SubMenuItemClass(
            key.toString(),
            data['menu_id'].toString(),
            data['name'].toString(),
            data['description'].toString(),
            data['image'].toString(),
            double.parse(data['price'].toString()),
            int.parse(data['discount'].toString()),
            (int.parse(data['is_active'].toString()) == 1),
          ));
        }
      });
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
    return items;
  }

  static Future<bool> sendMessage(String messageDetails) async {
    try {
      var dbRef2 = databaseRef.child('data').child('messages');
      await dbRef2.push().set({
        'user_id': DataManager.mPrefManager.getId().toString(),
        'message': messageDetails,
      }).then((value) {
        Fluttertoast.showToast(
          msg: "Message sent, we'll contact you as soon as possible.",
          toastLength: Toast.LENGTH_LONG,
        );
      });
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> submitLocation(
      String locationName, int locationTime, double locationFees,
      [String cLocationId = ""]) async {
    try {
      var dbRef2 = databaseRef.child('data').child('delivery_locations');
      if (cLocationId == "") {
        dbRef2 = dbRef2.push();
      } else {
        dbRef2 = dbRef2.child(cLocationId.toString());
      }
      await dbRef2.set({
        'name': locationName,
        'time': locationTime,
        'fees': locationFees,
      }).then((value) {
        if (cLocationId == "") {
          Fluttertoast.showToast(
            msg: "Location is successfully added.",
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Location is successfully updated.",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.messaage.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> submitCategory(String categoryName,
      [String cCategoryId = ""]) async {
    try {
      var dbRef2 = databaseRef.child('data').child('main_menu_categories');
      if (cCategoryId == "") {
        dbRef2 = dbRef2.push();
      } else {
        dbRef2 = dbRef2.child(cCategoryId.toString());
      }
      await dbRef2.set({
        'name': categoryName,
      }).then((value) {
        if (cCategoryId == "") {
          Fluttertoast.showToast(
            msg: "Category is successfully added.",
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Category is successfully updated.",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      });
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> submitMainMenuItem(
      String categoryId, String itemName, String itemImageURL, int isActive,
      [String mainMenuItemId = ""]) async {
    try {
      var dbRef2 = databaseRef.child('data').child('main_menu_items');
      if (mainMenuItemId == "") {
        dbRef2 = dbRef2.push();
      } else {
        dbRef2 = dbRef2.child(mainMenuItemId.toString());
      }
      await dbRef2.set({
        'category_id': categoryId,
        'name': itemName,
        'image': itemImageURL,
        'is_active': isActive
      }).then((value) {
        if (mainMenuItemId == "") {
          Fluttertoast.showToast(
            msg: "Main Menu Item is successfully added.",
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Main Menu Item is successfully updated.",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      });
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> submitSubMenuItem(
      String mainMenuItemId,
      String name,
      double price,
      int discount,
      String description,
      String imageURL,
      int isActive,
      [String cSubMenuItemId = ""]) async {
    try {
      var dbRef2 = databaseRef.child('data').child('sub_menu_items');
      if (cSubMenuItemId == "") {
        dbRef2 = dbRef2.push();
      } else {
        dbRef2 = dbRef2.child(cSubMenuItemId.toString());
      }
      await dbRef2.set({
        'menu_id': mainMenuItemId,
        'name': name,
        'price': price,
        'discount': discount,
        'description': description,
        'image': imageURL,
        'is_active': isActive,
      }).then((value) {
        if (cSubMenuItemId == "") {
          Fluttertoast.showToast(
            msg: "Item is successfully added.",
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Item is successfully updated.",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      });
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> deleteLocation(String locationId) async {
    try {
      databaseRef
          .child('data')
          .child('delivery_locations')
          .child(locationId)
          .remove()
          .then((value) {
        Fluttertoast.showToast(
          msg: "Location is successfully deleted.",
          toastLength: Toast.LENGTH_LONG,
        );
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.messaage.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> deleteCategory(String categoryId) async {
    try {
      databaseRef
          .child('data')
          .child('main_menu_categories')
          .child(categoryId)
          .remove()
          .then((value) {
        Fluttertoast.showToast(
          msg: "Category is successfully deleted.",
          toastLength: Toast.LENGTH_LONG,
        );
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.messaage.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> deleteMainMenuItem(String mainMenuItemId) async {
    try {
      await databaseRef
          .child('data')
          .child('main_menu_items')
          .child(mainMenuItemId)
          .child('is_active')
          .set(0);
      Fluttertoast.showToast(
        msg: "Main Menu Item is successfully deleted.",
        toastLength: Toast.LENGTH_LONG,
      );
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<bool> deleteSubMenuItem(String subMenuItemId) async {
    try {
      await databaseRef
          .child('data')
          .child('sub_menu_items')
          .child(subMenuItemId)
          .child('is_active')
          .set(0);
      Fluttertoast.showToast(
        msg: "Item is successfully deleted.",
        toastLength: Toast.LENGTH_LONG,
      );
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<List> getAllMessages() async {
    var path = '/messages.json';
    final List<Message> messages = [];
    final response = await http.get(url + path);
    final dbData = json.decode(response.body) as Map<String, dynamic>;
    dbData.forEach((key, data) async {
      var message = data['message'];
      var uid = data['user_id'];
      messages.add(Message(message, uid));
    });
    return messages;
  }
}
