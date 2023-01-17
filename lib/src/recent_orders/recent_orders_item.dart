class RecentOrdersItemClass {
  String id = "";
  String orderId = "";
  String itemId = "";
  String itemName = "";
  int qty = 0;
  double itemPrice = 0;

  RecentOrdersItemClass(String iId, String iOrderId, String iItemId, String iItemName,
      int iQTY, double iItemPrice) {
    this.id = iId;
    this.orderId = iOrderId;
    this.itemId = iItemId;
    this.itemName = iItemName;
    this.qty = iQTY;
    this.itemPrice = iItemPrice;
  }

  bool setId(String iId) {
    this.id = iId;
    return true;
  }

  bool setOrderId(String iOrderId) {
    this.orderId = iOrderId;
    return true;
  }

  bool setItemId(String iItemId) {
    this.itemId = iItemId;
    return true;
  }

  bool setItemName(String iItemName) {
    this.itemName = iItemName;
    return true;
  }

  bool setQTY(int iQTY) {
    this.qty = iQTY;
    return true;
  }

  bool setItemPrice(double iItemPrice) {
    this.itemPrice = iItemPrice;
    return true;
  }

  String getId() {
    return id;
  }

  String getOrderId() {
    return orderId;
  }

  String getItemId() {
    return itemId;
  }

  String getItemName() {
    return itemName;
  }

  int getQTY() {
    return qty;
  }

  double getItemPrice() {
    return itemPrice;
  }
}
