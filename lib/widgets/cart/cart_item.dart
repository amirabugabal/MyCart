import 'package:mycart/models/cart/cart_item.dart';
import 'package:mycart/models/sub_menu/sub_menu_item.dart';
import 'package:mycart/services/cart_manager.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/item/mini_add_remove_card.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  SubMenuItemClass mItem;
  String title;
  String picture;
  double price;
  int iniValue;
  Function reCalculate;

  CartItem(CartItemClass cItem, Function reCalculate) {
    this.mItem = cItem.mItem;
    this.title = cItem.mItem.getName();
    this.picture = cItem.mItem.getImagePath();
    this.price = cItem.totalPrice;
    this.iniValue = cItem.qty;
    this.reCalculate = reCalculate;
  }

  @override
  CartItemState createState() {
    return CartItemState();
  }
}

class CartItemState extends State<CartItem> {
  final noteController = TextEditingController();

  void addItem() {
    if (widget.iniValue < 50) {
      setState(
        () {
          if (CartManager.addItem(widget.mItem)) {
            widget.iniValue++;
            widget.price += widget.mItem.getFinalPrice();
            widget.reCalculate();
          }
        },
      );
    }
  }

  void removeItem() {
    if (widget.iniValue > 0) {
      setState(
        () {
          if (CartManager.removeItem(widget.mItem)) {
            widget.iniValue--;
            widget.price -= widget.mItem.getFinalPrice();
            widget.reCalculate();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 15,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: FadeInImage(
                      image: NetworkImage(
                        widget.picture,
                      ),
                      placeholder: AssetImage(
                        "assets/images/holders/sub_menu_item_holder.png",
                      ),
                      width: 55,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title.length > 13
                          ? widget.title.substring(0, 13) + "..."
                          : widget.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          (widget.price).toStringAsFixed(2).toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00af87),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          'EGP',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00af87),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          miniAddRemoveCard(0.7, widget.iniValue, addItem, removeItem),
        ],
      ),
    );
  }
}
