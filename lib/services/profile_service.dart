import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kDisplayName = 'display_name';

class ProfileService extends ChangeNotifier {
  String _displayName;

  ProfileService._(this._displayName);

  static Future<ProfileService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return ProfileService._(prefs.getString(_kDisplayName) ?? 'Me');
  }

  String get displayName => _displayName;

  Future<void> saveDisplayName(String name) async {
    final trimmed = name.trim().isEmpty ? 'Me' : name.trim();
    _displayName = trimmed;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kDisplayName, trimmed);
  }
}
