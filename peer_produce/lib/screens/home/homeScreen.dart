import 'package:flutter/material.dart';
import 'package:peer_produce/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade500,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: Text('Peer Produce'),
        actions: [
          FlatButton.icon(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white70,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.white70),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
