import 'package:flutter/material.dart';

class MyUser {
  final String uid;
  final bool isVerified;
  MyUser({@required this.uid, @required this.isVerified});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.name, this.sugars, this.strength});
}
