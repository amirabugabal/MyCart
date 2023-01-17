class MainMenuItemClass {
  String id = "";
  String categoryId = "";
  String name = "";
  String imagePath = "";
  bool isActive = false;

  MainMenuItemClass(String iId, String iCategoryId, String iName, String iImagePath,bool iIsActive) {
    this.id = iId;
    this.categoryId = iCategoryId;
    this.name = iName;
    this.imagePath = iImagePath;
    this.isActive = iIsActive;
  }

  bool setId(String iId) {
    this.id = iId;
    return true;
  }

  bool setCategoryId(String iCategoryId) {
    this.categoryId = iCategoryId;
    return true;
  }

  bool setName(String iName) {
    this.name = iName;
    return true;
  }

  bool setImagePath(String iImagePath) {
    this.imagePath = iImagePath;
    return true;
  }

  bool setIsActive(bool iIsActive) {
    this.isActive = iIsActive;
    return true;
  }

  String getId() {
    return id;
  }

  String getCategoryId() {
    return categoryId;
  }

  String getName() {
    return name;
  }

  String getImagePath() {
    return imagePath;
  }

  bool getIsActive() {
    return isActive;
  }
  
}
