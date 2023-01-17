import 'package:flutter/material.dart';
import 'package:mycart/models/main_menu/main_menu_category.dart';
import 'package:mycart/services/data_manager.dart';

class SubmitCategory extends StatefulWidget {
  static const routeName = '/submitCategory';

  Function callBackFunction;
  MainMenuCategoryClass cCategory;

  SubmitCategory([this.callBackFunction, this.cCategory]);

  @override
  _SubmitCategoryState createState() => _SubmitCategoryState();
}

class _SubmitCategoryState extends State<SubmitCategory> {
  final _formKey = GlobalKey<FormState>();

  final categoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.cCategory != null) {
      categoryController.text = widget.cCategory.name.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          title: Text(
            widget.cCategory == null ? 'Add Category' : 'Update Category',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 15, right: 9, top: 9, bottom: 9),
            child: IconButton(
              icon: Image.asset('assets/images/other_icons/back_arrow.png'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: 30,
              bottom: 30,
            ),
            children: [
              Image(
                image: AssetImage('assets/images/cat.png'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: categoryController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          isDense: true,
                          hintText: 'Category Name',
                          hintStyle: new TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Category name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
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
                              child: Text(
                                widget.cCategory == null
                                    ? 'Add Category'
                                    : 'Update Category',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              var category = categoryController.text;
                              DataManager.submitCategory(
                                category,
                                widget.cCategory != null
                                    ? widget.cCategory.id
                                    : "",
                              ).then((response) {
                                if (response) {
                                  Navigator.pop(context);
                                  if (widget.callBackFunction != null) {
                                    widget.callBackFunction();
                                  }
                                } else {}
                              });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
