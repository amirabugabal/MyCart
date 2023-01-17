class MainMenuCategoryClass {
  String id = "";
  String name = "";

  MainMenuCategoryClass(String iId, String iName) {
    this.id = iId;
    this.name = iName;
  }

  bool setId(String iId) {
    this.id = iId;
    return true;
  }

  bool setName(String iName) {
    this.name = iName;
    return true;
  }

  String getId() {
    return id;
  }

  String getName() {
    return name;
  }
}
