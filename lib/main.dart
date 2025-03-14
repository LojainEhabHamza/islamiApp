import 'package:flutter/material.dart';
import 'package:islami/config/app_routes.dart';
import 'package:islami/config/app_theme.dart';
import 'package:islami/features/home/presentation/pages/home_screen.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/pages/sura_details/sura_details_screen.dart';
import 'features/home/tabs/HadeethTab/presentation/pages/hadeeth_details/hadeeth_details_screen.dart';
import 'features/on_boarding/presentation/pages/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.homeRoute,
      routes: {
        AppRoutes.onBoardingRoute : (context) => OnBoardingScreen(),
        AppRoutes.homeRoute : (context) => HomeScreen(),
        AppRoutes.suraDetailsRoute:(context) => SuraDetailsScreen(),
        AppRoutes.hadeethDetailsRoute:(context) => HadeethDetailsScreen(),
      },
    );
  }
}