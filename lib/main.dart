import 'package:flutter/material.dart';
import 'package:note/core/di/injection.dart';
import 'package:note/features/onboard/presentation/screens/onboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependecies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: OnboardScreen(),
    );
  }
}
