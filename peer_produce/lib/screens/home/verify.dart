import 'package:flutter/material.dart';
import 'package:peer_produce/constants.dart';
import 'package:peer_produce/components/rounded_botton.dart';
import 'package:peer_produce/services/auth.dart';

class Verify extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade500,
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Check your email for a verification link.',
              style: kTextTitleStyle,
            ),
            SizedBox(height: 8.0),
            RoundedButton(
              title: 'Resend Email',
              backgroundColor: Colors.lightBlueAccent,
              onPress: () {
                _auth.sendVerificationEmail();
                _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
