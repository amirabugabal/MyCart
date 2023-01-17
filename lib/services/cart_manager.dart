import 'package:mycart/models/cart/cart_item.dart';
import 'package:mycart/models/sub_menu/sub_menu_item.dart';

class CartManager {
  static double subtotal = 0;
  static double deliveryFees = 0;
  static int deliveryTime = 0;
  static String promocode = "";
  static double discount = 0;
  static double totalPrice = 0;
  static String orderNote = "";
  static List mCart = new List();

  static bool addItem(SubMenuItemClass mItem, [int qty = 1]) {
    bool isAdded = false;
    for (CartItemClass cItem in CartManager.mCart) {
      if (cItem.id == mItem.id && !isAdded) {
        for (int i = 0; i < qty; i++) {
          cItem.addItem();
        }
        isAdded = true;
      }
    }
    if (!isAdded) {
      mCart.add(new CartItemClass(mItem, qty));
      isAdded = true;
    }
    if (isAdded) {
      CartManager.subtotal += mItem.getFinalPrice() * qty;
      CartManager.getTotalPrice();
    }
    return isAdded;
  }

  static bool removeItem(SubMenuItemClass mItem) {
    bool isRemoved = false;
    for (CartItemClass cItem in CartManager.mCart) {
      if (cItem.id == mItem.id && !isRemoved) {
        if (cItem.getQTY() > 1) {
          cItem.removeItem();
          isRemoved = true;
        }
      }
    }
    if (!isRemoved) {
      CartManager.mCart.removeWhere((element) => element.mItem.id == mItem.id);
      isRemoved = true;
    }
    if (isRemoved) {
      CartManager.subtotal -= mItem.getFinalPrice();
      CartManager.getTotalPrice();
    }
    return isRemoved;
  }

  static double getTotalPrice() {
    CartManager.totalPrice =
        CartManager.subtotal - CartManager.discount + CartManager.deliveryFees;
    return CartManager.totalPrice;
  }

  static bool clean() {
    CartManager.subtotal = 0;
    CartManager.deliveryFees = 0;
    CartManager.promocode = "";
    CartManager.discount = 0;
    CartManager.totalPrice = 0;
    CartManager.orderNote = "";
    CartManager.mCart.clear();
    return true;
  }
}
