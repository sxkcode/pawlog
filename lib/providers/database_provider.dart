import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_service.dart';

/// Placeholder overridden in [ProviderScope] before [runApp]; throwing here
/// makes a missing override immediately obvious rather than failing silently.
final databaseServiceProvider = Provider<DatabaseService>(
  (ref) => throw UnimplementedError('DatabaseService not initialized'),
);
