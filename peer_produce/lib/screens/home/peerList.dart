import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peer_produce/models/peer.dart';
import 'package:peer_produce/screens/home/peerTile.dart';

class PeerList extends StatefulWidget {
  @override
  _PeerListState createState() => _PeerListState();
}

class _PeerListState extends State<PeerList> {
  @override
  Widget build(BuildContext context) {
    final peers = Provider.of<List<Peer>>(context) ?? [];

    return ListView.builder(
      itemCount: peers.length,
      itemBuilder: (context, index) {
        return PeerTile(peer: peers[index]);
      },
    );
  }
}
