import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../services/pet_service.dart';
import 'database_provider.dart';

final petServiceProvider = ChangeNotifierProvider<PetService>(
  (ref) => PetService(ref.watch(databaseServiceProvider)),
);

final petListProvider = Provider<List<Pet>>(
  (ref) => ref.watch(petServiceProvider).pets,
);

final petLoadingProvider = Provider<bool>(
  (ref) => ref.watch(petServiceProvider).isLoading,
);
