import 'package:flutter/material.dart';
import 'package:peminjaman/login.page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lerftsxcltdcjbboocri.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlcmZ0c3hjbHRkY2piYm9vY3JpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgyNTQwOTcsImV4cCI6MjA4MzgzMDA5N30.rEhhzfR_WGfoq72sV8fkRrjU-F39vq4PABUHMv_8ctA',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
