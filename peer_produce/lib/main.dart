import 'package:flutter/material.dart';
import 'package:peer_produce/models/user.dart';
import 'package:peer_produce/screens/wrapper.dart';
import 'package:peer_produce/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<myUser>(
      create: (_) {
        return AuthService().user;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
