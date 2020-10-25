import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peer_produce/services/auth.dart';
import 'package:peer_produce/services/database.dart';
import 'package:peer_produce/screens/home/peerList.dart';
import 'package:peer_produce/screens/home/settingsForm.dart';
import 'package:peer_produce/models/peer.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 60.0,
                vertical: 20.0,
              ),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Peer>>.value(
      value: DatabaseService().peers,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade500,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade800,
          title: Text('Peer Produce'),
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.power_settings_new, color: Colors.white70),
              label: Text('Logout', style: TextStyle(color: Colors.white70)),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings, color: Colors.white70),
              label: Text('Settings', style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
        body: PeerList(),
      ),
    );
  }
}
