import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';

/// Overridden with the real instance before runApp(); never called as-is.
final databaseServiceProvider = Provider<DatabaseService>(
  (ref) => throw UnimplementedError('DatabaseService not initialized'),
);

class DatabaseService {
  final AppDatabase db;

  DatabaseService(this.db);

  static DatabaseService create() => DatabaseService(AppDatabase());
}
