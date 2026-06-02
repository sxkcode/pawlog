import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/system_blueprints.dart';
import '../../../database/database.dart';
import '../../../providers/event_provider.dart';
import '../../../providers/pet_provider.dart';

const _coral = Color(0xFFF05D5E);
const _sand = Color(0xFFD8A47F);

class EventFab extends ConsumerStatefulWidget {
  const EventFab({super.key});

  @override
  ConsumerState<EventFab> createState() => _EventFabState();
}

class _EventFabState extends ConsumerState<EventFab> {
  bool _sheetOpen = false;
  int _step = 1;
  final _selectedKeys = <String>[];
  final _selectedPetIds = <int>[];
  List<Pet>? _pets;
  bool _saving = false;
  StateSetter? _setSheetState;

  Future<void> _openSheet() async {
    _step = 1;
    _selectedKeys.clear();
    _selectedPetIds.clear();
    _pets = null;
    _saving = false;
    _setSheetState = null;
    setState(() => _sheetOpen = true);
    _loadPets();
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, ss) {
          _setSheetState = ss;
          return _buildSheet(ctx, ss);
        },
      ),
    );
    if (mounted) setState(() => _sheetOpen = false);
  }

  Future<void> _loadPets() async {
    final pets = await ref.read(petServiceProvider).allPets();
    if (!mounted) return;
    (_setSheetState ?? setState)(() => _pets = pets);
  }

  Future<void> _handleDone(BuildContext ctx, StateSetter ss) async {
    ss(() => _saving = true);
    await ref.read(eventServiceProvider).logEvents(
      systemComponentKeys: List.of(_selectedKeys),
      petIds: List.of(_selectedPetIds),
    );
    if (ctx.mounted) Navigator.of(ctx).pop();
  }

  Widget _buildSheet(BuildContext ctx, StateSetter ss) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16, 20, 16, MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: _step == 1 ? _buildStep1(ctx, ss) : _buildStep2(ctx, ss),
      ),
    );
  }

  Widget _buildStep1(BuildContext ctx, StateSetter ss) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('What happened?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        for (final b in SystemBlueprint.values)
          CheckboxListTile(
            title: Text(_labelFor(b)),
            value: _selectedKeys.contains(b.name),
            onChanged: (v) => ss(() {
              if (v == true) { _selectedKeys.add(b.name); }
              else { _selectedKeys.remove(b.name); }
            }),
            activeColor: _coral,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _selectedKeys.isEmpty ? null : () => ss(() => _step = 2),
          style: ElevatedButton.styleFrom(
            backgroundColor: _coral,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            disabledForegroundColor: Colors.grey.shade500,
          ),
          child: const Text('NEXT →'),
        ),
      ],
    );
  }

  Widget _buildStep2(BuildContext ctx, StateSetter ss) {
    final pets = _pets;
    final canDone = pets != null && pets.isNotEmpty && _selectedPetIds.isNotEmpty && !_saving;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Which pets?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        if (pets == null)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (pets.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'No pets added yet. Add a pet in the Pets tab first.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          )
        else
          for (final p in pets)
            CheckboxListTile(
              title: Text(p.name),
              secondary: CircleAvatar(
                backgroundColor: _sand,
                child: Text(p.name[0].toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              value: _selectedPetIds.contains(p.id),
              onChanged: _saving
                  ? null
                  : (v) => ss(() {
                        if (v == true) { _selectedPetIds.add(p.id); }
                        else { _selectedPetIds.remove(p.id); }
                      }),
              activeColor: _coral,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _saving ? null : () => ss(() => _step = 1),
                child: const Text('← BACK'),
              ),
            ),
            if (pets != null && pets.isNotEmpty) ...[
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: canDone ? () { _handleDone(ctx, ss); } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _coral,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.grey.shade500,
                  ),
                  child: _saving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('DONE ✓'),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  static String _labelFor(SystemBlueprint b) => switch (b) {
        SystemBlueprint.poop => 'Pooped',
        SystemBlueprint.pee => 'Peed',
        SystemBlueprint.walk => 'Went for a walk',
        SystemBlueprint.medication => 'Took medication',
        SystemBlueprint.play => 'Played',
        SystemBlueprint.training => 'Did training',
      };

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _sheetOpen ? () => Navigator.of(context).pop() : _openSheet,
      backgroundColor: _coral,
      foregroundColor: Colors.white,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          _sheetOpen ? Icons.close : Icons.add,
          key: ValueKey(_sheetOpen),
        ),
      ),
    );
  }
}
