import 'package:flutter/foundation.dart';
import '../database/database.dart';
import 'database_service.dart';

class EventService extends ChangeNotifier {
  final DatabaseService _svc;
  List<EventWithPet> _events = [];

  EventService(this._svc) {
    _load();
  }

  List<EventWithPet> get events => _events;

  Future<void> _load() async {
    _events = await _svc.db.getAllEventsSortedByTimestamp();
    notifyListeners();
  }

  Future<void> refresh() => _load();

  List<EventWithPet> allEventsSorted() => _events;
}
