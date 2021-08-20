import 'dart:io';
import 'package:flutter/foundation.dart';

class NetworkNotifier with ChangeNotifier {
  bool isConnected;

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> setIsConnected() {
    return hasNetwork().then((value) {
      isConnected = value;
      notifyListeners();
    });
  }

  bool get getIsConnected {
    return isConnected;
  }
}
