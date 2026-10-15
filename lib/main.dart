import 'package:alaa_protfolio/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alaa Nazeh',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeView(
        isDarkMode: _isDarkMode,
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}