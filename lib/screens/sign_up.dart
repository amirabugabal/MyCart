import 'package:flutter/services.dart';
import 'package:mycart/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:mycart/services/auth.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  @override
  SignUpScreenState createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = Auth();
  String _name, _phone, _email, _password;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[ A-Za-z]")),
                      ],
                      controller: nameController,
                      onSaved: (value) {
                        _name = value;
                      },
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        isDense: true,
                        hintText: 'Full Name',
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
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextFormField(
                      controller: phoneController,
                      onSaved: (value) {
                        _phone = value;
                      },
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        isDense: true,
                        hintText: 'Phone Number',
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
                          return 'Please enter your phone number';
                        } else if (value.length != 11) {
                          return 'Please enter 11 number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
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
                    child: TextFormField(
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Confirm Password',
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
                          return 'Please confirm your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords doesn\'t match';
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
                                  'Sign Up',
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
                                  await _auth.signUp(
                                      _name, _phone, _email, _password);

                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          "Sign up success, please login")));
                                  Navigator.pushNamed(
                                      context, SignInScreen.routeName);
                                } catch (e) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(e.message.toString())));
                                }
                              }
                            })),
                  ),
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
                        Navigator.pop(context);
                        //Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text(
                            "Already have an account? ",
                          ),
                          new Text(
                            "Log In",
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
