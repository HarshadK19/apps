import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/services/auth.dart';
import 'package:app/shared/loading.dart';

class SignIn extends StatefulWidget {

  // for swapping forms
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  // Spinner
  bool loading = false;

  // Text Field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.none,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: 'test@email.com',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        labelText: 'Email Address',
                      ),
                      validator: (val) => val.isEmpty ? 'Enter an email address' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Password',
                    ),
                    validator: (val) => val.length < 6 ? 'Enter an password for 6 characters long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: 50,
                      right: 50,
                    ),
                    textColor: Colors.black,
                    child: Text(
                      'Login',
                    ),
                    onPressed: () async {
                      // Validate the form by evaluating it
                      if (_formkey.currentState.validate()) {
                        // Spinner to appear
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        // check if null
                        if (result == null) {
                          // Pop Up error box
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  'Error'
                                ),
                                content: Text(
                                  'Could not sign in with credentials!'
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'OK'
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                          );
                          setState(() { 
                            loading = false; // spinner to not appear
                          });
                        }
                        // Automatically on success goes on home due to STREAM
                      }
                    },
                  ),
                  Text(
                    'OR'
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: OutlineButton(
                      splashColor: Colors.grey,
                      onPressed: () {
                        _auth.googlelogin();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      highlightElevation: 0,
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/google_logo.png"),
                              height: 35.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RichText(
                          text: new TextSpan(
                            children: [
                              new TextSpan(
                                text: "Do not have an account?",
                                style: TextStyle(color: Colors.black87),
                              ),
                              new TextSpan(
                                text: " Click Here!",
                                style: TextStyle(color: Colors.lightBlue),
                                recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  widget.toggleView();
                                }
                              )
                            ]
                          ) 
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}