import 'package:flutter/material.dart';
import 'package:peer_produce/models/peer.dart';

class PeerTile extends StatelessWidget {
  final Peer peer;
  PeerTile({this.peer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[peer.strength],
          ),
          title: Text(peer.name),
          subtitle: Text('Takes ${peer.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
