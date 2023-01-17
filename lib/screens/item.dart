import 'package:mycart/models/sub_menu/sub_menu_item.dart';
import 'package:mycart/screens/my_cart.dart';
import 'package:mycart/screens/order_placed.dart';
import 'package:mycart/services/cart_manager.dart';
import 'package:mycart/services/data_manager.dart';
import 'package:mycart/widgets/item/mini_add_remove_card.dart';
import 'package:mycart/widgets/item/mini_specs_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatefulWidget {
  static const appBarTitle = 'Item';
  static const routeName = '/item';
  SubMenuItemClass mItem;

  ItemScreen(SubMenuItemClass mItem) {
    this.mItem = mItem;
  }

  @override
  ItemScreenState createState() {
    return ItemScreenState();
  }
}

class ItemScreenState extends State<ItemScreen> {
  int iniValue = 0;

  void addItem() {
    setState(() {
      iniValue++;
    });
  }

  void removeItem() {
    setState(() {
      if (iniValue > 0) {
        iniValue--;
      }
    });
  }

  void navigateTo() {
    Navigator.pushNamed(context, OrderPlacedScreen.routeName);
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
          leading: Padding(
            padding: EdgeInsets.only(left: 15, right: 9, top: 9, bottom: 9),
            child: IconButton(
              icon: Image.asset('assets/images/other_icons/back_arrow.png'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 3, right: 15, top: 5, bottom: 5),
              child: IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: Colors.grey,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, MyCartScreen.routeName),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(/*top: 22,*/ left: 30, right: 30, bottom: 22),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 22),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: FadeInImage(
                            image: NetworkImage(
                              widget.mItem.getImagePath(),
                            ),
                            placeholder: AssetImage(
                              "assets/images/holders/item_holder.png",
                            ),
                          ),
                        ),
                        (widget.mItem.discount != 0)
                            ? FractionallySizedBox(
                                widthFactor: 0.3,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFd86464),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: AutoSizeText(
                                      widget.mItem.discount.toString() +
                                          '% OFF',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.mItem.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  (widget.mItem.discount != 0
                                          ? widget.mItem.getFinalPrice()
                                          : widget.mItem.price)
                                      .toString(),
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
                            SizedBox(
                              width: 12,
                            ),
                            (widget.mItem.discount != 0)
                                ? Row(
                                    children: [
                                      Text(
                                        widget.mItem.price.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'EGP',
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 12,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.mItem.description,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      miniAddRemoveCard(1, iniValue, addItem, removeItem),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF00d466),
                                    Color(0xFF00af87),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 88.0, minHeight: 55),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Add to cart',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (iniValue > 0) {
                                CartManager.addItem(widget.mItem, iniValue);
                              }
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
