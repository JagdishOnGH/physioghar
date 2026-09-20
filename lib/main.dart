import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/screen_launcher.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/schedule/schedule_screen.dart';
import 'features/bookings/bookings_screen.dart';
import 'features/patients/patient_list_screen.dart';
import 'features/account/account_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PhysioGharApp(),
    ),
  );
}

class PhysioGharApp extends StatelessWidget {
  const PhysioGharApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhysioGhar Therapist',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainShellScreen(),
    );
  }
}

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  void _navigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(onNavigateTab: _navigateToTab),
      const ScheduleScreen(),
      const BookingsScreen(),
      const PatientListScreen(),
      const AccountScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton.small(
          onPressed: () => ScreenLauncher.showCatalog(context, onSelectTab: _navigateToTab),
          backgroundColor: AppColors.accent,
          elevation: 4,
          tooltip: 'Browse All 10 Screens',
          child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 20),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_online_outlined),
              activeIcon: Icon(Icons.book_online),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Patients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
