import 'package:mycart/screens/sign_up.dart';
import 'package:mycart/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mycart/services/auth.dart';

import 'sign_up.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';

  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
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
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 30, bottom: 10),
                    child: Image.asset(
                      MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? "assets/images/main/logo.png"
                          : "assets/images/main/logo_c.png",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: TextFormField(
                      onSaved: (value) {
                        _email = value;
                      },
                      controller: emailController,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        isDense: true,
                        hintText: 'Email',
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
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextFormField(
                      onSaved: (value) {
                        _password = value;
                      },
                      controller: passwordController,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Password',
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
                        suffixIcon: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: _togglePasswordView,
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      obscureText: _isHidden,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Builder(
                        builder: (context) => RaisedButton(
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
                                    'Log In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  try {
                                    await _auth.signIn(_email, _password);
                                    Navigator.pushReplacementNamed(
                                      context,
                                      SplashScreen.routeName,
                                    );
                                  } catch (e) {
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(content: Text(e.message)));
                                  }
                                }
                              },
                            )),
                  ),
                  /*new Container( ////////////////////////////// REMOVED TILL ACCEPTANCE ON GOOGLE PLAY
                    padding: const EdgeInsets.only(top: 21.0, bottom: 5.0),
                    alignment: Alignment.center,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ForgotPasswordScreen.routeName);
                      },
                      child: new Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 36,
                        ),
                      ),
                    ),
                    Text(
                      "or",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(
                      child: new Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 5.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 36,
                        ),
                      ),
                    ),
                  ]),
                  new Text(
                    "You can sign in with",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 88.0),
                            height: 55,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: Image.asset(
                                "assets/images/social/google_logo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onPressed: () {
                            print("G");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 88.0),
                            height: 55,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(17),
                              child: Image.asset(
                                "assets/images/social/facebook_logo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onPressed: () {
                            print("FB");
                          },
                        ),
                      ),
                    ],
                  ),*/
                  SizedBox(
                    height: 5,
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
