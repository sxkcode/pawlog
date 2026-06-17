// Persists the user's ThemeMode preference using shared_preferences and exposes
// the current mode synchronously after async initialization. Synchronous access
// after init means MaterialApp.themeMode can be set on the first frame without
// a FutureBuilder or a default-then-update flash. NOT responsible for the
// actual theme data (colors, typography) — those are defined in main.dart.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeMode = 'theme_mode';

class ThemeService extends ChangeNotifier {
  ThemeMode _mode;

  ThemeService._(this._mode);

  /// Async factory that reads the persisted theme mode before returning.
  ///
  /// Must be called in [main] before [runApp] and injected via
  /// [ProviderScope.overrides]. Defaults to [ThemeMode.system] when no
  /// preference has been saved yet.
  static Future<ThemeService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return ThemeService._(_fromString(prefs.getString(_kThemeMode) ?? 'system'));
  }

  /// The current [ThemeMode]; available synchronously after [create] returns.
  ThemeMode get mode => _mode;

  /// Updates the theme mode, calls [notifyListeners], then persists the choice.
  ///
  /// [notifyListeners] fires before the SharedPreferences write so
  /// [MaterialApp] re-renders immediately; the persist follows on the same
  /// call stack.
  Future<void> setMode(ThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kThemeMode, _toString(mode));
    } catch (e, st) {
      debugPrint('ThemeService.setMode: $e\n$st');
    }
  }

  /// Converts a stored string back to [ThemeMode].
  ///
  /// Human-readable strings (`'light'`, `'dark'`, `'system'`) are stored
  /// rather than integer indices so the preference is readable during debug
  /// inspection of the shared_preferences file.
  static ThemeMode _fromString(String s) => switch (s) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  static String _toString(ThemeMode m) => switch (m) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };
}
