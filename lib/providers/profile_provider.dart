import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/profile_service.dart';

final profileServiceProvider = ChangeNotifierProvider<ProfileService>(
  (ref) => throw UnimplementedError('ProfileService must be initialized in main'),
);
