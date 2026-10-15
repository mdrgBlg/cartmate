import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Holds the Firebase SDK instances. Instances are resolved lazily so
/// constructing this service never touches Firebase before
/// `Firebase.initializeApp` has completed.
class FirebaseService {
  FirebaseService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _auth = auth,
       _firestore = firestore,
       _storage = storage;

  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  FirebaseStorage? _storage;

  FirebaseAuth get auth => _auth ??= FirebaseAuth.instance;

  FirebaseFirestore get firestore => _firestore ??= FirebaseFirestore.instance;

  FirebaseStorage get storage => _storage ??= FirebaseStorage.instance;
}
