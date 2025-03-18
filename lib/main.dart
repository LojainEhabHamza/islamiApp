import 'package:flutter/material.dart';
import 'package:islami/config/app_routes.dart';
import 'package:islami/config/app_theme.dart';
import 'package:islami/core/cache/shared_preference_utils.dart';
import 'package:islami/features/home/presentation/pages/home_screen.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/pages/sura_details/sura_details_screen.dart';
import 'package:islami/features/home/tabs/HadeethTab/presentation/pages/hadeeth_details/hadeeth_details_screen.dart';
import 'package:islami/features/home/tabs/RadioTab/data/models/RecitersResponseModel.dart';
import 'package:islami/features/home/tabs/RadioTab/presentation/manager/radio_provider.dart';
import 'package:islami/features/home/tabs/RadioTab/presentation/pages/sura_list_screen.dart';
import 'package:islami/features/on_boarding/presentation/pages/on_boarding_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceUtils.init();

  bool isFirstTime = SharedPreferenceUtils.getData(key: 'isFirstTime') as bool? ?? true;
  String initialRoute = isFirstTime ? AppRoutes.onBoardingRoute : AppRoutes.homeRoute;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RadioProvider()),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: initialRoute,
      routes: {
        AppRoutes.onBoardingRoute: (context) => OnBoardingScreen(),
        AppRoutes.homeRoute: (context) => HomeScreen(),
        AppRoutes.suraDetailsRoute: (context) => SuraDetailsScreen(),
        AppRoutes.hadeethDetailsRoute: (context) => HadeethDetailsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.suraListRoute) {
          final reciter = settings.arguments as Reciters;
          return MaterialPageRoute(
            builder: (context) => SuraListScreen(reciter: reciter),
          );
        }
        return null;
      },
    );
  }
}