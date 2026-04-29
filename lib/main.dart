import 'package:docs/views/pager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum Pages { home, documentation, downloads }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Website(),
        '/docs': (context) => const Website(),
        '/downloads': (context) => const Website(),
      },
    );
  }
}