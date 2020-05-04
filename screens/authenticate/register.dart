import 'package:firebase_tutorial/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_tutorial/services/auth.dart';
import 'package:firebase_tutorial/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[300],
            appBar: AppBar(
              backgroundColor: Colors.green[500],
              elevation: 0.0,
              title: Text("Create Account"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text(
                      "Sign in",
                    ))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    //login
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecorationLogin.copyWith(hintText: "Email"),
                      validator: (val) => val.isEmpty
                          ? 'Enter an email' // String is an helper text
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    //password
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecorationLogin.copyWith(hintText: "Password"),
                      validator: (val) => (val.length < 6)
                          ? 'Password must be 6+ characters long' //helper texts
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    RaisedButton(
                      color: Colors.amber,
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(
                                () => error = "please enter a valid email");
                                loading = false;
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
