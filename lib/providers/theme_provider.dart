import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/theme_service.dart';

final themeServiceProvider = ChangeNotifierProvider<ThemeService>(
  (ref) => throw UnimplementedError('ThemeService must be initialized in main'),
);
