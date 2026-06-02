import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../services/event_service.dart';
import '../services/database_service.dart';

final eventServiceProvider = ChangeNotifierProvider<EventService>(
  (ref) => EventService(ref.watch(databaseServiceProvider)),
);

final eventListProvider = Provider<List<EventWithPet>>(
  (ref) => ref.watch(eventServiceProvider).events,
);
