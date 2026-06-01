import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/dummy_data.dart';

final eventListProvider = Provider<List<DummyEvent>>((ref) => dummyEvents);
