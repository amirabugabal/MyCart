import 'package:mycart/screens/my_cart.dart';
import 'package:mycart/screens/order_placed.dart';
import 'package:mycart/widgets/item/mini_add_remove_card.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatefulWidget {
  static const appBarTitle = 'Item';
  static const routeName = '/item';
  List mItem;

  ItemScreen(List mItem) {
    this.mItem = mItem;
  }

  @override
  ItemScreenState createState() {
    return ItemScreenState();
  }
}

class ItemScreenState extends State<ItemScreen> {
  int iniValue = 1;

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
                  Color(0xFF89CFF0),
                  Color(0xFF0047AB),
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
                              widget.mItem[3],
                            ),
                            placeholder: AssetImage(
                              "assets/images/holders/item_holder.png",
                            ),
                          ),
                        ),
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
                            widget.mItem[2],
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
                                 widget.mItem[4]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF89CFF0),
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
                                    color: Color(0xFF89CFF0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
                                    Color(0xFF89CFF0),
                                    Color(0xFF0047AB),
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
                            onPressed: () {},
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
