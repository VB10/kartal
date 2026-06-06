import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

extension NetworkInfoExtension on BuildContext {
  Future<String?> get wifiIP async {
    final networkInfo = NetworkInfo();
    try {
      return await networkInfo.getWifiIP();
    } on Object catch (_) {
      return null;
    }
  }

  Future<String?> get wifiName async {
    final networkInfo = NetworkInfo();
    try {
      return await networkInfo.getWifiName();
    } on Object catch (_) {
      return null;
    }
  }

  Future<String?> get wifiBSSID async {
    final networkInfo = NetworkInfo();
    try {
      return await networkInfo.getWifiBSSID();
    } on Object catch (_) {
      return null;
    }
  }

  Future<String> get hostname async {
    try {
      final name = await NetworkInfo().getWifiName();
      return name ?? 'unknown';
    } on Object catch (_) {
      return 'unknown';
    }
  }
}
