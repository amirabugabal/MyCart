class SubMenuItemClass {
  String id = "";
  String menuId = "";
  String name = "";
  String description = "";
  String imagePath = "";
  double price = 0;
  int discount = 0;
  bool isActive = false;

  SubMenuItemClass(
    String iId,
    String iMenuId,
    String iName,
    String iDescription,
    String iImagePath,
    double iPrice,
    int iDiscount,
    bool iIsActive,
  ) {
    this.id = iId;
    this.menuId = iMenuId;
    this.name = iName;
    this.description = iDescription;
    this.imagePath = iImagePath;
    this.price = iPrice;
    this.discount = iDiscount;
    this.isActive = iIsActive;
  }

  bool setId(String iId) {
    this.id = iId;
    return true;
  }

  bool setName(String iName) {
    this.name = iName;
    return true;
  }

  bool setDescription(String iDescription) {
    this.description = iDescription;
    return true;
  }

  bool setImagePath(String iImagePath) {
    this.imagePath = iImagePath;
    return true;
  }

  bool setPrice(double iPrice) {
    this.price = iPrice;
    return true;
  }

  bool setDiscount(int iDiscount) {
    this.discount = iDiscount;
    return true;
  }

  bool setIsActive(bool iIsActive) {
    this.isActive = iIsActive;
    return true;
  }

  String getId() {
    return id;
  }

  String getName() {
    return name;
  }

  String getDescription() {
    return description;
  }

  String getImagePath() {
    return imagePath;
  }

  double getPrice() {
    return price;
  }

  int getDiscount() {
    return discount;
  }

  bool getIsActive() {
    return isActive;
  }

  double getFinalPrice() {
    if (discount == 0) {
      return price;
    } else {
      return double.parse(
          (price - (price * (discount / 100))).toStringAsFixed(2));
    }
  }
}
