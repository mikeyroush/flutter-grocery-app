import 'package:flutter/material.dart';
import 'package:peer_produce/screens/authenticate/register.dart';
import 'package:peer_produce/screens/authenticate/signIn.dart';
import 'package:peer_produce/constants.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  ScreenState state = ScreenState.logIn;

  void toggleState() {
    if (state == ScreenState.logIn) {
      setState(() {
        state = ScreenState.register;
      });
    } else {
      setState(() {
        state = ScreenState.logIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return state == ScreenState.logIn
        ? SignIn(toggleState: toggleState)
        : Register(toggleState: toggleState);
  }
}
