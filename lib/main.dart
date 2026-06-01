import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/nav_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/pets/pets_screen.dart';
import 'screens/calendar/calendar_screen.dart';
import 'screens/settings/settings_screen.dart';

const _teal = Color(0xFF0F7173);
const _background = Color(0xFFE7ECEF);
const _surface = Color(0xFFFFFFFF);
const _navBar = Color(0xFF272932);
const _coral = Color(0xFFF05D5E);
const _sand = Color(0xFFD8A47F);
const _ink = Color(0xFF272932);

void main() {
  runApp(const ProviderScope(child: PawlogApp()));
}

class PawlogApp extends StatelessWidget {
  const PawlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawlog',
      debugShowCheckedModeBanner: false,
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

    return Scaffold(
      appBar: selectedIndex == 0
          ? AppBar(
              title: const Text('Pawlog'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundColor: _sand,
                    child: const Text(
                      'SK',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: IndexedStack(
        index: selectedIndex,
        children: _screens,
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            )
          : null,
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
