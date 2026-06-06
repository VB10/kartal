import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

extension ConnectivityExtension on BuildContext {
  bool get isOnline => _connectivity != ConnectivityResult.none;

  bool get isOffline => _connectivity == ConnectivityResult.none;

  bool get isWifi => _connectivity == ConnectivityResult.wifi;

  bool get isCellular => _connectivity == ConnectivityResult.mobile;

  bool get isEthernet => _connectivity == ConnectivityResult.ethernet;

  ConnectivityResult get _connectivity => _connectivityResults.first;

  static final List<ConnectivityResult> _connectivityResults = [
    ConnectivityResult.none
  ];

  static StreamController<ConnectivityResult>? _connectivityController;

  static Stream<ConnectivityResult> get onConnectivityChanged {
    _connectivityController ??=
        StreamController<ConnectivityResult>.broadcast();
    return _connectivityController!.stream;
  }

  static Future<void> init() async {
    final results = await Connectivity().checkConnectivity();
    _connectivityResults
      ..clear()
      ..addAll(results);
    Connectivity().onConnectivityChanged.listen((results) {
      _connectivityResults
        ..clear()
        ..addAll(results);
      if (_connectivityController != null &&
          !_connectivityController!.isClosed) {
        _connectivityController!.add(results.first);
      }
    });
  }

  static Future<bool> checkConnectivity() async {
    final results = await Connectivity().checkConnectivity();
    _connectivityResults
      ..clear()
      ..addAll(results);
    return results.any((r) => r != ConnectivityResult.none);
  }
}
