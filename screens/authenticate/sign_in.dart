import 'package:firebase_tutorial/services/auth.dart';
import 'package:firebase_tutorial/shared/constants.dart';
import 'package:firebase_tutorial/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[300],
            appBar: AppBar(
              backgroundColor: Colors.green[500],
              elevation: 0.0,
              title: Text("Sign in"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text(
                      "Register",
                    ))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  //login
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecorationLogin.copyWith(hintText: "Email"),
                    validator: (val) => (val.isEmpty) ? 'Enter an email' : null,
                    autocorrect: true,
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
                    validator: (val) =>
                        (val.length < 6) ? 'Password too short' : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  RaisedButton(
                    color: Colors.amber,
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = "COULD NOT SIGN IN";
                            loading = false;
                          });
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
                  ),
                ]),
              ),
            ),
          );
  }
}
