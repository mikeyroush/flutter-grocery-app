import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peer_produce/models/peer.dart';
import 'package:peer_produce/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference peerCollection =
      FirebaseFirestore.instance.collection('peers');

  Future updateUserData(String sugars, String name, int strength) async {
    return await peerCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // peer list from snapshot
  List<Peer> _peerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Peer(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0',
      );
    }).toList();
  }

  // get peers stream
  Stream<List<Peer>> get peers {
    return peerCollection.snapshots().map(_peerListFromSnapshot);
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      strength: snapshot.data()['strength'],
      sugars: snapshot.data()['sugars'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return peerCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
