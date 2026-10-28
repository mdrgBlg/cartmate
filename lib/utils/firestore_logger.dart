import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, QuerySnapshot;
import 'package:flutter/foundation.dart';

const String _logName = 'Firestore';
const int _maxPayloadLength = 2000;
const int _severeLevel = 1000;

class FirestoreLogger {
  const FirestoreLogger();

  Future<QuerySnapshot<Map<String, dynamic>>> traceQuery(
    String operation,
    String path,
    Future<QuerySnapshot<Map<String, dynamic>>> Function() call,
  ) async {
    final stopwatch = Stopwatch()..start();
    try {
      final snapshot = await call();
      if (kDebugMode) {
        final ms = stopwatch.elapsedMilliseconds;
        final source = snapshot.metadata.isFromCache ? 'cache' : 'server';
        final data = snapshot.docs
            .map((d) => <String, dynamic>{'id': d.id, ...d.data()})
            .toList();
        log(
          '$operation GET $path -> ${snapshot.docs.length} doc(s), ${ms}ms, '
          '$source | data: ${_truncate(data)}',
          name: _logName,
        );
      }
      return snapshot;
    } catch (e, st) {
      _logError(operation, path, e, st);
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> traceDoc(
    String operation,
    String path,
    Future<DocumentSnapshot<Map<String, dynamic>>> Function() call,
  ) async {
    final stopwatch = Stopwatch()..start();
    try {
      final snapshot = await call();
      if (kDebugMode) {
        final ms = stopwatch.elapsedMilliseconds;
        log(
          '$operation GET $path -> exists: ${snapshot.exists}, ${ms}ms '
          '| data: ${_truncate(snapshot.data())}',
          name: _logName,
        );
      }
      return snapshot;
    } catch (e, st) {
      _logError(operation, path, e, st);
      rethrow;
    }
  }

  Future<void> traceWrite(
    String operation,
    String method,
    String path,
    Future<void> Function() call, {
    Object? request,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      await call();
      if (kDebugMode) {
        final ms = stopwatch.elapsedMilliseconds;
        log(
          '$operation $method $path ${ms}ms'
          '${request == null ? '' : ' | request: ${_truncate(request)}'}',
          name: _logName,
        );
      }
    } catch (e, st) {
      _logError(operation, path, e, st);
      rethrow;
    }
  }

  void parseFailure(
    String operation,
    String docId,
    Map<String, dynamic> data,
    Object error,
    StackTrace stackTrace,
  ) {
    final fieldTypes = data.map(
      (k, v) => MapEntry<String, Type>(k, v.runtimeType),
    );
    log(
      '$operation: failed to parse doc $docId, field types: $fieldTypes',
      name: _logName,
      level: _severeLevel,
      error: error,
      stackTrace: stackTrace,
    );
    if (kDebugMode) {
      log('$operation: doc $docId data: ${_truncate(data)}', name: _logName);
    }
  }

  void _logError(
    String operation,
    String path,
    Object error,
    StackTrace stackTrace,
  ) {
    log(
      '$operation $path failed',
      name: _logName,
      level: _severeLevel,
      error: error,
      stackTrace: stackTrace,
    );
  }

  String _truncate(Object? value) {
    final text = value.toString();
    if (text.length <= _maxPayloadLength) {
      return text;
    }
    return '${text.substring(0, _maxPayloadLength)}'
        '... (+${text.length - _maxPayloadLength} chars)';
  }
}
