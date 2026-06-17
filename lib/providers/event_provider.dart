import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../services/event_service.dart';
import 'database_provider.dart';

final eventServiceProvider = ChangeNotifierProvider<EventService>(
  (ref) => EventService(ref.watch(databaseServiceProvider)),
);

final eventListProvider = Provider<List<EventWithPet>>(
  (ref) => ref.watch(eventServiceProvider).events,
);

final eventLoadingProvider = Provider<bool>(
  (ref) => ref.watch(eventServiceProvider).isLoading,
);
