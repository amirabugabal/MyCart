import 'package:mycart/models/cart/cart_item.dart';
import 'package:mycart/screens/admin/submit_category.dart';
import 'package:mycart/services/cart_manager.dart';
import 'package:mycart/services/firebase_manager.dart';
import 'dart:async';
import 'package:mycart/services/perference_manager.dart';

class DataManager {
  static PrefManager mPrefManager = new PrefManager();
  static List deliveryLocations = new List();
  static List userAddresses = new List();
  static String mainMenuBanner = "https://miumun.org/mobileimages/banner.png";
  static List mainMenuCategories = new List();
  static List mainMenuItems = new List();
  static List subMenuItems = new List();
  static List searchItems = new List();
  static List lastSearchKeywords = new List();
  static List recentOrders = new List();
  static List offersItems = new List();
  static bool isDarkMode = false;

  static Future<void> iniUserAddresses([Function callBackFunction]) async {
    DataManager.deliveryLocations =
        await FirebaseManager.getDeliveryLocations();
    DataManager.userAddresses = await FirebaseManager.getUserAddresses();
    if (DataManager.mPrefManager.getSelectedAddress() == "") {
      if (DataManager.deliveryLocations != null &&
          DataManager.userAddresses != null &&
          DataManager.userAddresses.length > 0) {
        DataManager.mPrefManager
            .setSelectedAddress(DataManager.userAddresses[0].id.toString());
      } else {}
    }
    if (DataManager.userAddresses != null) {
      DataManager.mPrefManager.updateDeliveryFeesAndTime();
    }
    if (callBackFunction != null) {
      callBackFunction();
    }
  }

  static Future<void> iniMainMenuCategories() async {
    DataManager.mainMenuCategories =
        await FirebaseManager.getMainMenuCategories();
  }

  static Future<void> iniMainMenuItems() async {
    DataManager.mainMenuItems = await FirebaseManager.getMainMenuItems();
  }

  static Future<void> iniSubMenuItems(String id) async {
    DataManager.subMenuItems = await FirebaseManager.getSubMenuItems(id);
  }

  static Future<void> iniSearchItems(String searchKey) async {
    DataManager.searchItems = await FirebaseManager.getSearchItems(searchKey);
  }

  static Future<void> iniRecentOrders() async {
    DataManager.recentOrders = await FirebaseManager.getRecentOrders();
  }

  static Future<bool> submitAddress(locationId, streetName, buildingNumber,
      floorNumber, apartmentNumber, phoneNumber,
      [String addressId = ""]) async {
    return await FirebaseManager.submitAddress(locationId, streetName,
        buildingNumber, floorNumber, apartmentNumber, phoneNumber, addressId);
  }

  static Future<bool> deleteAddress(addressId) async {
    return await FirebaseManager.deleteAddress(addressId);
  }

  static Future<bool> placeOrder() async {
    List<dynamic> myCartItems = new List();
    for (CartItemClass x in CartManager.mCart) {
      myCartItems.add(x.getAsMap());
    }
    Map<String, dynamic> myOrder = {
      'sub_total': CartManager.subtotal,
      'delivery_fees': CartManager.deliveryFees,
      'promocode': CartManager.promocode,
      'discount': CartManager.discount,
      'order_note': CartManager.orderNote,
      'total_price': CartManager.getTotalPrice(),
      'delivery_address_id': DataManager.mPrefManager.getSelectedAddress(),
      'status': 0,
      'time': 0,
      'user_id': DataManager.mPrefManager.id,
      'items': myCartItems,
    };
    await FirebaseManager.placeOrder(myOrder);
    await DataManager.iniRecentOrders();
    CartManager.clean();
    return true;
  }

  static Future<void> iniOffersItems() async {
    DataManager.offersItems = await FirebaseManager.getOffersItems();
  }

  static Future<bool> sendMessage(String messageDetails) async {
    return await FirebaseManager.sendMessage(messageDetails);
  }

  static Future<bool> submitLocation(
      String locationName, int locationTime, double locationFees,
      [String cLocationId = ""]) async {
    return await FirebaseManager.submitLocation(
            locationName, locationTime, locationFees, cLocationId)
        .then((value) async {
      await DataManager.iniUserAddresses();
    });
  }

  static Future<bool> submitCategory(String categoryName,
      [String cCategoryId = ""]) async {
    return await FirebaseManager.submitCategory(categoryName, cCategoryId)
        .then((value) async {
      await DataManager.iniMainMenuCategories();
      return true;
    });
  }

  static Future<bool> submitMainMenuItem(
      String categoryId, String itemName, String itemImageURL, int isActive,
      [String mainMenuItemId = ""]) async {
    return await FirebaseManager.submitMainMenuItem(
            categoryId, itemName, itemImageURL, isActive, mainMenuItemId)
        .then((value) async {
      await DataManager.iniMainMenuItems();
    });
  }

  static Future<bool> submitSubMenuItem(
      String mainMenuItemId,
      String name,
      double price,
      int discount,
      String description,
      String imageURL,
      int isActive,
      [String subMenuItemId = ""]) async {
    return await FirebaseManager.submitSubMenuItem(mainMenuItemId, name, price,
        discount, description, imageURL, isActive, subMenuItemId);
  }

  static Future<bool> deleteLocation(String locationId) async {
    return await FirebaseManager.deleteLocation(locationId).then((value) async {
      await DataManager.iniUserAddresses();
    });
  }

  static Future<bool> deleteCategory(String categoryId) async {
    return await FirebaseManager.deleteCategory(categoryId).then((value) async {
      await DataManager.iniMainMenuCategories();
    });
  }

  static Future<bool> deleteMainMenuItem(String mainMenuItemId) async {
    return await FirebaseManager.deleteMainMenuItem(mainMenuItemId)
        .then((value) async {
      await DataManager.iniMainMenuItems();
    });
  }

  static Future<bool> deleteSubMenuItem(String subMenuItemId) async {
    return await FirebaseManager.deleteSubMenuItem(subMenuItemId);
  }

  static Future<dynamic> getAllMessages() async {
    return await FirebaseManager.getAllMessages();
  }
}
