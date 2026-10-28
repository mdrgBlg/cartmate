import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Holds the Firebase SDK instances. Instances are resolved lazily so
/// constructing this service never touches Firebase before
/// `Firebase.initializeApp` has completed.
class FirebaseService {
  FirebaseService({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth,
      _firestore = firestore;

  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;

  FirebaseAuth get auth => _auth ??= FirebaseAuth.instance;

  FirebaseFirestore get firestore => _firestore ??= FirebaseFirestore.instance;
}
