import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Segoe UI',
        scaffoldBackgroundColor: AppColors.cream,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
