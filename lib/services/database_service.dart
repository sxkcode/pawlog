// Thin wrapper that owns the single AppDatabase instance. The wrapper exists
// so services receive a typed DatabaseService rather than a raw AppDatabase,
// making the injection point explicit and testable. NOT responsible for any
// query logic — all SQL lives in AppDatabase. The Riverpod provider for this
// service lives in lib/providers/database_provider.dart per project convention.
import '../database/database.dart';

class DatabaseService {
  final AppDatabase db;

  DatabaseService(this.db);

  /// Creates the singleton [DatabaseService] with a default [AppDatabase].
  ///
  /// Called once in [main] before [runApp]; the result is injected via
  /// [databaseServiceProvider.overrideWithValue].
  static DatabaseService create() => DatabaseService(AppDatabase());
}
