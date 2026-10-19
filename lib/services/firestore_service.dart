import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Stores each record with its owner's Firebase UID.
class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _records =>
      _firestore.collection('user_records');

  Future<void> saveRecord({
    required String name,
    required int age,
    required String favouriteHobby,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('You must sign in first.');

    await _records.add({
      'uid': user.uid,
      'name': name.trim(),
      'age': age,
      'favouriteHobby': favouriteHobby.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Only records belonging to the signed-in user are displayed.
  Stream<QuerySnapshot<Map<String, dynamic>>> watchRecords() {
    final user = _auth.currentUser;
    if (user == null) throw StateError('You must sign in first.');
    return _records.where('uid', isEqualTo: user.uid).snapshots();
  }
}
