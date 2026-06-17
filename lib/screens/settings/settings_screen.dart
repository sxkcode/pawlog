import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../providers/event_provider.dart';
import '../../providers/pet_provider.dart';
import '../../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static Widget _header(String label) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade500,
            letterSpacing: 1.1,
          ),
        ),
      );

  static Future<void> _showInfo(BuildContext context, String title) =>
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: const Text('Coming soon.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );

  Future<void> _confirmClear(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all data?'),
        content: const Text(
          'This will permanently delete all pets and events. '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await ref.read(petServiceProvider).clearAll();
      await ref.read(eventServiceProvider).refresh();
    } catch (_) {
      // Error already logged by the service; UI reflects whatever the DB
      // actually contains after the failed operation.
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeServiceProvider).mode;

    return ListView(
      children: [
        // ── Appearance ───────────────────────────────────────────────
        _header('Appearance'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode_outlined)),
              ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode_outlined)),
              ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.brightness_auto)),
            ],
            selected: {themeMode},
            onSelectionChanged: (s) =>
                ref.read(themeServiceProvider).setMode(s.first),
          ),
        ),
        const Divider(height: 1),

        // ── Notifications ─────────────────────────────────────────────
        _header('Notifications'),
        ListTile(
          leading: const Icon(Icons.notifications_outlined),
          title: const Text('Push notifications'),
          subtitle: const Text('Coming soon'),
          enabled: false,
        ),
        const Divider(height: 1),

        // ── Data ──────────────────────────────────────────────────────
        _header('Data'),
        ListTile(
          leading:
              Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700),
          title: const Text('Clear all data'),
          onTap: () => _confirmClear(context, ref),
        ),
        const Divider(height: 1),

        // ── About ─────────────────────────────────────────────────────
        _header('About'),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (ctx, snap) => ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            trailing: Text(
              snap.data?.version ?? '…',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.article_outlined),
          title: const Text('Terms of Service'),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => _showInfo(context, 'Terms of Service'),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => _showInfo(context, 'Privacy Policy'),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
