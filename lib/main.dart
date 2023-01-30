import 'package:flutter/material.dart';
import 'package:jobsity_test/core/injector.dart';
import 'package:jobsity_test/core/theme.dart';
import 'package:jobsity_test/view/page/list_shows_page.dart';

void main() {
  Injector.inject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      home: const ListTVShowsPage(),
    );
  }
}
