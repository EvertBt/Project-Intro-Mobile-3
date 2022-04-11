import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

class Authenticator {
  static String _generatehash({String password = ""}) {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  static Future<void> _initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> updatePassword(String newPassword) async {
    await _initialize();

    await FirebaseFirestore.instance
        .doc('authadmin/password')
        .update({'value': _generatehash(password: newPassword)});
  }

  static Future<bool> authenticate(String password) async {
    await _initialize();

    var result = await FirebaseFirestore.instance
        .collection('authadmin')
        .where('value', isEqualTo: _generatehash(password: password))
        .get();

    return result.docs.isNotEmpty;
  }
}
