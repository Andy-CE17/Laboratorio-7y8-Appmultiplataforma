import 'dart:typed_data';

import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  AppSettings._();

  static final AppSettings instance = AppSettings._();

  String name = 'Andy Campos';
  String email = 'admin@demo.com';
  Uint8List? avatarBytes;
  Color accent = const Color(0xFFFF5A0A);
  bool notificationsEnabled = true;

  void updateProfile({required String name, required String email}) {
    this.name = name;
    this.email = email;
    notifyListeners();
  }

  void updateAvatar(Uint8List bytes) {
    avatarBytes = bytes;
    notifyListeners();
  }

  void updateAccent(Color color) {
    accent = color;
    notifyListeners();
  }

  void updateNotifications(bool enabled) {
    notificationsEnabled = enabled;
    notifyListeners();
  }
}
