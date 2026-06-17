import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants/dummy_data.dart';
import 'providers/nav_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/widgets/event_fab.dart';
import 'screens/pets/pet_detail_screen.dart';
import 'screens/pets/pets_screen.dart';
import 'screens/calendar/calendar_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'services/database_service.dart';
import 'services/profile_service.dart';
import 'services/theme_service.dart';

const _teal = Color(0xFF0F7173);
const _background = Color(0xFFE7ECEF);
const _surface = Color(0xFFFFFFFF);
const _navBar = Color(0xFF272932);
const _coral = Color(0xFFF05D5E);
const _sand = Color(0xFFD8A47F);
const _ink = Color(0xFF272932);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbService = DatabaseService.create();
  final profileService = await ProfileService.create();
  final themeService = await ThemeService.create();

  // Seed with demo data on first launch (empty DB).
  final existingPets = await dbService.db.getPetsForUser();
  if (existingPets.isEmpty) {
    await seedDatabase(dbService);
  }

  runApp(
    ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(dbService),
        profileServiceProvider.overrideWith((ref) => profileService),
        themeServiceProvider.overrideWith((ref) => themeService),
      ],
      child: const PawlogApp(),
    ),
  );
}

class PawlogApp extends ConsumerWidget {
  const PawlogApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeServiceProvider).mode;
    return MaterialApp(
      title: 'Pawlog',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _teal).copyWith(
          primary: _teal,
          surface: _surface,
          onSurface: _ink,
        ),
        scaffoldBackgroundColor: _background,
        appBarTheme: const AppBarTheme(
          backgroundColor: _teal,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: _navBar,
          selectedItemColor: _coral,
          unselectedItemColor: _background.withValues(alpha: 0.55),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _coral,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key});

  static const _screens = <Widget>[
    HomeScreen(),
    PetsScreen(),
    CalendarScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navIndexProvider);
    final displayName = ref.watch(profileServiceProvider).displayName;
    final avatarInitial = displayName.trim().isNotEmpty
        ? displayName.trim()[0].toUpperCase()
        : 'M';

    return Scaffold(
      appBar: switch (selectedIndex) {
        0 => AppBar(
            title: const Text('Pawlog'),
            actions: [
              PopupMenuButton<String>(
                offset: const Offset(0, 48),
                onSelected: (value) {
                  if (value == 'profile') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const ProfileScreen()));
                  } else if (value == 'settings') {
                    ref.read(navIndexProvider.notifier).state = 3;
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'profile', child: Text('Edit Profile')),
                  //PopupMenuItem(value: 'settings', child: Text('Settings')),
                ],
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundColor: _sand,
                    child: Text(
                      avatarInitial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        1 => AppBar(
            title: const Text('My Pets'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Add pet',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const PetDetailScreen()),
                ),
              ),
            ],
          ),
        2 => AppBar(title: const Text('Calendar')),
        3 => AppBar(title: const Text('Settings')),
        _ => null,
      },
      body: IndexedStack(
        index: selectedIndex,
        children: _screens,
      ),
      floatingActionButton: selectedIndex == 0 ? const EventFab() : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) => ref.read(navIndexProvider.notifier).state = i,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Pets'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
