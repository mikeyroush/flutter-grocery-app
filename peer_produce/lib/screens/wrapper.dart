import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:peer_produce/models/user.dart';
import 'package:peer_produce/services/auth.dart';
import 'package:peer_produce/screens/authenticate/authenticateScreen.dart';
import 'package:peer_produce/screens/home/verify.dart';
import 'package:peer_produce/screens/errorScreen.dart';
import 'package:peer_produce/screens/home/homeScreen.dart';
import 'package:peer_produce/screens/loadingScreen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _initialized = false;
  bool _error = false;

  // initialize Firebase
  void initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        print('Initialized: $_initialized');
      });
    } catch (e) {
      setState(() {
        _error = true;
        print('Error: $_error');
      });
    }
  }

  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return loading, error, home or authenticate screen
    if (_error)
      return ErrorScreen();
    else if (!_initialized)
      return LoadingScreen();
    else {
      final user = Provider.of<myUser>(context);
      return user == null
          ? Authenticate()
          : !user.isVerified ? Verify() : Home();
    }
  }
}
