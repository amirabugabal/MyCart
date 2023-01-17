import 'package:mycart/models/sub_menu/sub_menu_item.dart';

class CartItemClass {
  String id = "";
  SubMenuItemClass mItem;
  int qty = 0;
  double totalPrice = 0;

  CartItemClass(SubMenuItemClass mItem, [int qty = 1]) {
    this.id = mItem.id;
    this.mItem = mItem;
    this.qty = qty;
    this.totalPrice = mItem.getFinalPrice() * qty;
  }

  bool addItem() {
    qty++;
    totalPrice = mItem.getFinalPrice() * qty;
    return true;
  }

  bool removeItem() {
    qty--;
    totalPrice = mItem.getFinalPrice() * qty;
    return true;
  }

  String getId() {
    return this.getId();
  }

  int getQTY() {
    return this.qty;
  }

  double getTotalPrice() {
    return this.getTotalPrice();
  }

  Map<String, dynamic> getAsMap() => {
        'item_id': mItem.getId(),
        'item_name': mItem.getName(),
        'qty': qty,
        'item_price': mItem.getFinalPrice(),
      };
}
