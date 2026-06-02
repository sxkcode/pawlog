import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/pet_provider.dart';
import 'pet_detail_screen.dart';

const _sand = Color(0xFFD8A47F);
const _ink = Color(0xFF272932);

class PetsScreen extends ConsumerWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pets = ref.watch(petListProvider);

    if (pets.isEmpty) {
      return const Center(
        child: Text(
          'No pets yet. Tap + to add your first pet.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: pets.length,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 72),
      itemBuilder: (ctx, i) {
        final p = pets[i];
        final species = p.species;
        final breed = p.breed;
        String? subtitle;
        if (species != null && species.isNotEmpty) {
          subtitle = (breed != null && breed.isNotEmpty)
              ? '$species · $breed'
              : species;
        }
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: _sand,
            child: Text(
              p.name[0].toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(p.name,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: _ink)),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => Navigator.of(ctx).push(
            MaterialPageRoute(builder: (_) => PetDetailScreen(pet: p)),
          ),
        );
      },
    );
  }
}
