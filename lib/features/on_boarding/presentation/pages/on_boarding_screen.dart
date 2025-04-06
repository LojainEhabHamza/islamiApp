import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_strings.dart';
import 'package:islami/features/on_boarding/data/models/on_boarding_data.dart';
import 'package:islami/features/on_boarding/presentation/widgets/on_boarding_page.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  List<OnBoardingData> onBoardingList = [
    OnBoardingData(imagePath: AppAssets.onBoarding1, title: AppStrings.title1),
    OnBoardingData(imagePath: AppAssets.onBoarding1, title: AppStrings.title2, description: AppStrings.description2),
    OnBoardingData(imagePath: AppAssets.onBoarding1, title: AppStrings.title3, description: AppStrings.description3),
    OnBoardingData(imagePath: AppAssets.onBoarding1, title: AppStrings.title4, description: AppStrings.description4),
    OnBoardingData(imagePath: AppAssets.onBoarding1, title: AppStrings.title5, description: AppStrings.description5),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: Center(
              child: Image.asset(AppAssets.islamiLogo, height: height * 0.25),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onBoardingList.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnBoardingPage(
                  onBoardingData: onBoardingList[index],
                  currentIndex: currentIndex,
                  pageController: pageController,
                  totalPages: onBoardingList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}