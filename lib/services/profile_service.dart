// Persists the user's display name across sessions using shared_preferences.
// The name is stored denormalized on each Event row as loggedByName at write
// time, so historical events retain the name that was active when they were
// logged — changing the display name does not retroactively update past events.
// NOT responsible for authentication or multi-user identity; in Phase 1 there
// is a single unnamed "local user". Firebase Auth replaces this in Phase 2.
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kDisplayName = 'display_name';

class ProfileService extends ChangeNotifier {
  String _displayName;

  ProfileService._(this._displayName);

  /// Async factory that reads the persisted display name before returning.
  ///
  /// Must be called in [main] before [runApp] and injected via
  /// [ProviderScope.overrides] so the name is available synchronously on the
  /// first frame — widgets must not call this themselves.
  static Future<ProfileService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return ProfileService._(prefs.getString(_kDisplayName) ?? 'Me');
  }

  /// The current display name; defaults to `'Me'` if none has been saved.
  String get displayName => _displayName;

  /// Persists [name] and calls [notifyListeners].
  ///
  /// Empty or whitespace-only input is normalized to `'Me'` so the loggedByName
  /// field on Event rows is never blank. [notifyListeners] is called before the
  /// SharedPreferences write so the UI updates optimistically; the async persist
  /// follows immediately after on the same call stack.
  Future<void> saveDisplayName(String name) async {
    final trimmed = name.trim().isEmpty ? 'Me' : name.trim();
    _displayName = trimmed;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kDisplayName, trimmed);
    } catch (e, st) {
      debugPrint('ProfileService.saveDisplayName: $e\n$st');
    }
  }
}
