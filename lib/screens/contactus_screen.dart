import 'package:flutter/material.dart';
import 'package:mycart/services/data_manager.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = '/contact-us';

  @override
  ContactUsScreenState createState() {
    return ContactUsScreenState();
  }
}

class ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();

  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
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
            'Contact Us',
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
                top: 30),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 30, bottom: 10),
                      child: Image.asset(
                        "assets/images/main/logo_c.png",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: TextFormField(
                        controller: messageController,
                        minLines: 10,
                        maxLines: 30,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          isDense: true,
                          hintText: 'How can we help you?',
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
                            return 'Please enter your message';
                          } else if (value.length < 10) {
                            return 'Minimum value is 10 characters';
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
                            child: const Text(
                              'Send',
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
                            var message = messageController.text;
                            DataManager.sendMessage(message).then((response) {
                              if (response) {
                                Navigator.pop(context);
                              } else {}
                            });
                          }
                        },
                      ),
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
