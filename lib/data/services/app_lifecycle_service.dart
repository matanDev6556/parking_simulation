import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppLifecycleService {
  final FirebaseFirestore _firestore;
  Timer? _heartbeatTimer;
  final Duration _heartbeatInterval = Duration(seconds: 30);

  AppLifecycleService(this._firestore);

  Future<void> startHeartbeat(String userId) async {
    // Update initial timestamp
    await _updateLastActive(userId);

    // Start periodic heartbeat
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) async {
      await _updateLastActive(userId);
    });
  }

  Future<void> _updateLastActive(String userId) async {
    await _firestore.collection('user_status').doc(userId).set({
      'last_active': FieldValue.serverTimestamp(),
      'status': 'active',
    }, SetOptions(merge: true));
  }

  Future<void> markUserOffline(String userId) async {
    await _firestore.collection('user_status').doc(userId).set({
      'status': 'offline',
      'last_offline': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  void stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }
}
