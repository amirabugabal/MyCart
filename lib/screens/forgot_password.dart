import 'package:mycart/screens/sign_up.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password';

  @override
  ForgotPasswordScreenState createState() {
    return ForgotPasswordScreenState();
  }
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 30, bottom: 10),
                    child: Image.asset(
                      "assets/main/images/logo_c.png",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: TextFormField(
                      controller: emailController,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        isDense: true,
                        hintText: 'Email',
                        hintStyle: new TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.grey[100],
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
                          return 'Please enter your email';
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
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0, minHeight: 55),
                          alignment: Alignment.center,
                          child: const Text(
                            'Reset Password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onPressed: () {
                        print("RST");
                      },
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    alignment: Alignment.center,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: new Text(
                        "Retrieve account through phone number",
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 35,
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    alignment: Alignment.center,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.black),
                          ),
                          new Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xFF00af87),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
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
