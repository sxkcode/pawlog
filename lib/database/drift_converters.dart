// Drift TypeConverter implementations that bridge SQLite's native column types
// and Dart's richer types. SQLite has no native array or DateTime type, so
// List<String> and List<int> are stored as JSON strings, and DateTime is stored
// as milliseconds since epoch (an integer). These converters are referenced by
// column definitions in database.dart and are never called directly by
// application code — Drift invokes them transparently on every read and write.
import 'dart:convert';
import 'package:drift/drift.dart';

/// Stores a [List<String>] as a JSON array string in SQLite.
///
/// Example round-trip: `["poop", "pee"]` ↔ stored as `'["poop","pee"]'`.
/// Used for [Events.systemComponents].
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) =>
      // json.decode always returns List<dynamic>; cast<String>() re-types the
      // elements without allocating a new list.
      (json.decode(fromDb) as List<dynamic>).cast<String>();

  @override
  String toSql(List<String> value) => json.encode(value);
}

/// Stores a [List<int>] as a JSON array string in SQLite.
///
/// Example round-trip: `[1, 3]` ↔ stored as `'[1,3]'`.
/// Used for [Events.customBlueprintIds].
class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> fromSql(String fromDb) =>
      // Same cast pattern as StringListConverter; json numbers decode to int
      // on native Dart but to num on some JS runtimes — cast<int>() normalises.
      (json.decode(fromDb) as List<dynamic>).cast<int>();

  @override
  String toSql(List<int> value) => json.encode(value);
}

/// Stores a [DateTime] as milliseconds since epoch in a SQLite INTEGER column.
///
/// Integer storage was chosen over ISO-8601 text because SQLite ORDER BY and
/// range comparisons on integers are cheaper than string comparisons, and the
/// epoch-ms representation is what [DateTime.fromMillisecondsSinceEpoch]
/// expects natively. All timestamps are stored in local time.
class DateTimeConverter extends TypeConverter<DateTime, int> {
  const DateTimeConverter();

  @override
  DateTime fromSql(int fromDb) => DateTime.fromMillisecondsSinceEpoch(fromDb);

  @override
  int toSql(DateTime value) => value.millisecondsSinceEpoch;
}
