import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tractor_finance_app/report_page.dart';

import 'expense_page.dart';
import 'income_page.dart'; // Import your IncomePage or other pages

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tractor Finance App',
      // Set the default locale to Persian (fa)
      locale: const Locale('fa', 'IR'),
      // Define supported locales (currently only Persian)
      supportedLocales: const [
        Locale('fa', 'IR'), // Persian (Iran)
      ],
      // Add localizations delegates for RTL support
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Ensure proper locale resolution for RTL
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first; // Fallback to the first supported locale
      },
      theme: ThemeData(
        fontFamily: 'Vazir', // Use a Persian font like Vazir
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
      ),
      home: IncomePage(), // Replace with your home page
    );
  }
}

class BottomNavigationExample extends StatefulWidget {
  @override
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _selectedIndex = 0;

  // List of pages to display
  static final List<Widget> _pages = [
    IncomePage(),
    ExpensePage(),
    ReportPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'افزودن درآمد',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_circle),
            label: 'افزودن هزینه',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'گزارش گیری',
          ),
        ],
      ),
    );
  }
}


// git init
// git add README.md
// git commit -m "first commit"
// git branch -M main
// git remote add origin https://github.com/asgharkarimi/finance_app.git
// git push -u origin main
