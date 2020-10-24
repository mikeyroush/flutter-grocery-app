import 'package:flutter/material.dart';
import 'package:peer_produce/components/rounded_botton.dart';
import 'package:peer_produce/screens/loadingScreen.dart';
import 'package:peer_produce/services/auth.dart';
import 'package:peer_produce/models/user.dart';
import 'package:peer_produce/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleState;
  SignIn({this.toggleState});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String email = '';
  String pass = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return _loading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.blueGrey.shade500,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey.shade800,
              title: Text('Sign in to Peer Produce'),
              actions: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.white70,
                  ),
                  label: Text(
                    'Register',
                    style: TextStyle(color: Colors.white70),
                  ),
                  onPressed: () {
                    widget.toggleState();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Enter an Email' : null,
                      style: kTextFieldStyle,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Email'),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      obscureText: true,
                      validator: (value) => value.length < 6
                          ? 'Enter a password of 6+ characters'
                          : null,
                      style: kTextFieldStyle,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Password'),
                      onChanged: (value) {
                        setState(() {
                          pass = value;
                        });
                      },
                    ),
                    RoundedButton(
                      title: 'Sign In',
                      backgroundColor: Colors.lightBlueAccent,
                      onPress: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => _loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, pass);
                          if (result.runtimeType != myUser) {
                            setState(() {
                              error = result;
                              _loading = false;
                            });
                          }
                        }
                        // dynamic result = await _auth.signInAnonymously();
                        // result == null
                        //     ? print('error signing in')
                        //     : print('signed in\n${result.uid}');
                      },
                    ),
                    SizedBox(height: 8.0),
                    Text(error, style: TextStyle(color: Colors.redAccent)),
                  ],
                ),
              ),
            ),
          );
  }
}
