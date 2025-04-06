import 'package:flutter/material.dart';
import 'package:islami/core/cache/shared_preference_utils.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_constants.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/on_boarding/data/models/on_boarding_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:islami/config/app_routes.dart';

class OnBoardingPage extends StatefulWidget {
  final OnBoardingData onBoardingData;
  final int currentIndex;
  final PageController pageController;
  final int totalPages;

  OnBoardingPage({
    required this.onBoardingData,
    required this.currentIndex,
    required this.pageController,
    required this.totalPages,
    Key? key,
  }) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
      child: Column(
        children: [
          Expanded(child: Image.asset(widget.onBoardingData.imagePath)),
          SizedBox(height: height * 0.02),
          Text(widget.onBoardingData.title, style: AppStyles.bold24Primary),
          SizedBox(height: height * 0.02),
          Text(
            widget.onBoardingData.description ?? '',
            style: AppStyles.bold20Primary,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                child: widget.currentIndex > 0
                    ? TextButton(
                  onPressed: () {
                    widget.pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(AppConstants.back, style: AppStyles.bold16Primary),
                )
                    : SizedBox(width: width * 0.15),
              ),
              SmoothPageIndicator(
                effect: WormEffect(
                  dotWidth: 12,
                  dotHeight: 12,
                  dotColor: AppColors.greyColor,
                  activeDotColor: AppColors.primaryColor,
                ),
                controller: widget.pageController,
                count: widget.totalPages,
              ),
              TextButton(
                onPressed: () async {
                  if (widget.currentIndex < widget.totalPages - 1) {
                    widget.pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    await SharedPreferenceUtils.saveData(key: 'isFirstTime', value: false);
                    Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
                  }
                },
                child: Text(
                  widget.currentIndex == widget.totalPages - 1
                      ? AppConstants.finish
                      : AppConstants.next,
                  style: AppStyles.bold16Primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}