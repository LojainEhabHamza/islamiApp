import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_constants.dart';
import 'package:islami/features/home/tabs/HadeethTab/presentation/pages/hadeeth_tab.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/pages/quran_tab.dart';
import 'package:islami/features/home/tabs/RadioTab/presentation/pages/radio_tab.dart';
import 'package:islami/features/home/tabs/SebhaTab/presentation/pages/sebha_tab.dart';
import 'package:islami/features/home/tabs/TimeTab/presentation/pages/time_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> backgroundImages = [
    AppAssets.quranBackgroundImage,
    AppAssets.hadeethBackgroundImage,
    AppAssets.sebhaBackgroundImage,
    AppAssets.radioBackgroundImage,
    AppAssets.prayerBackgroundImage
  ];
  List<Widget> tabs = [
    QuranTab(),
    HadeethTab(),
    SebhaTab(),
    RadioTab(),
    TimeTab()
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Image.asset(backgroundImages[selectedIndex],
            width: double.infinity, height: double.infinity, fit: BoxFit.fill),
        Scaffold(
          body: tabs[selectedIndex],
          bottomNavigationBar: Theme(
            data:
                Theme.of(context).copyWith(canvasColor: AppColors.primaryColor),
            child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                      icon: buildItemInBottomNavBar(
                          index: 0,
                          imageName: AppAssets.quranIcon,
                          width: width,
                          height: height),
                      label: AppConstants.quran),
                  BottomNavigationBarItem(
                      icon: buildItemInBottomNavBar(
                          index: 1,
                          imageName: AppAssets.hadeethIcon,
                          width: width,
                          height: height),
                      label: AppConstants.hadeeth),
                  BottomNavigationBarItem(
                      icon: buildItemInBottomNavBar(
                          index: 2,
                          imageName: AppAssets.sebhaIcon,
                          width: width,
                          height: height),
                      label: AppConstants.sebha),
                  BottomNavigationBarItem(
                      icon: buildItemInBottomNavBar(
                          index: 3,
                          imageName: AppAssets.radioIcon,
                          width: width,
                          height: height),
                      label: AppConstants.radio),
                  BottomNavigationBarItem(
                      icon: buildItemInBottomNavBar(
                          index: 4,
                          imageName: AppAssets.prayerIcon,
                          width: width,
                          height: height),
                      label: AppConstants.time),
                ]),
          ),
        )
      ],
    );
  }

  Widget buildItemInBottomNavBar(
      {required int index,
      required String imageName,
      required double width,
      required double height}) {
    return selectedIndex == index
        ? Container(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.04),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(66),
                color: AppColors.blackBgColor),
            child: ImageIcon(AssetImage(imageName)))
        : ImageIcon(AssetImage(imageName));
  }
}
