import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../providers/event_provider.dart';
import '../../providers/pet_provider.dart';

const _coral = Color(0xFFF05D5E);
const _sand = Color(0xFFD8A47F);

class PetDetailScreen extends ConsumerStatefulWidget {
  final Pet? pet;
  const PetDetailScreen({super.key, this.pet});

  @override
  ConsumerState<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends ConsumerState<PetDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _species;
  late final TextEditingController _breed;
  DateTime? _birthdate;
  bool _saving = false;

  bool get _isEdit => widget.pet != null;

  @override
  void initState() {
    super.initState();
    final p = widget.pet;
    _name = TextEditingController(text: p?.name ?? '');
    _species = TextEditingController(text: p?.species ?? '');
    _breed = TextEditingController(text: p?.breed ?? '');
    if (p?.birthdate != null) {
      _birthdate = DateTime.fromMillisecondsSinceEpoch(p!.birthdate!);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _species.dispose();
    _breed.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final petSvc = ref.read(petServiceProvider);
    if (_isEdit) {
      final updated = widget.pet!.copyWith(
        name: _name.text.trim(),
        species: Value(_species.text.trim().isEmpty ? null : _species.text.trim()),
        breed: Value(_breed.text.trim().isEmpty ? null : _breed.text.trim()),
        birthdate: Value(_birthdate?.millisecondsSinceEpoch),
      );
      await petSvc.updatePet(updated);
    } else {
      await petSvc.addPet(
        name: _name.text.trim(),
        species: _species.text.trim().isEmpty ? null : _species.text.trim(),
        breed: _breed.text.trim().isEmpty ? null : _breed.text.trim(),
        birthdate: _birthdate,
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete pet?'),
        content: Text(
          'This will also delete all events for ${widget.pet!.name}. '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: _coral),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _saving = true);
    await ref.read(petServiceProvider).deletePet(widget.pet!.id);
    await ref.read(eventServiceProvider).refresh();
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthdate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) setState(() => _birthdate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final nameInitial =
        _name.text.isNotEmpty ? _name.text[0].toUpperCase() : '?';
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Pet' : 'Add Pet'),
        actions: _isEdit
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Delete pet',
                  onPressed: _saving ? null : _confirmDelete,
                ),
              ]
            : null,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: _sand,
                    child: Text(nameInitial,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32)),
                  ),
                  const SizedBox(height: 6),
                  const Text('Add photo coming soon',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                  labelText: 'Name *', border: OutlineInputBorder()),
              onChanged: (_) => setState(() {}),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _species,
              decoration: const InputDecoration(
                  labelText: 'Species',
                  hintText: 'e.g. Dog, Cat',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _breed,
              decoration: const InputDecoration(
                  labelText: 'Breed',
                  hintText: 'e.g. Golden Retriever',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_birthdate == null
                  ? 'Date of birth'
                  : 'Born: ${_fmtDate(_birthdate!)}'),
              subtitle: _birthdate == null
                  ? const Text('Optional — tap to set')
                  : null,
              trailing: _birthdate == null
                  ? const Icon(Icons.calendar_today, color: Colors.grey)
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() => _birthdate = null),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.grey),
                      ],
                    ),
              onTap: _saving ? null : _pickDate,
            ),
            const Divider(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  (_name.text.trim().isEmpty || _saving) ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: _coral,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                disabledForegroundColor: Colors.grey.shade500,
                minimumSize: const Size.fromHeight(48),
              ),
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(_isEdit ? 'Save Changes' : 'Add Pet'),
            ),
          ],
        ),
      ),
    );
  }

  static String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}
