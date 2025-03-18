import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_strings.dart';
import 'package:islami/core/utils/app_styles.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 1;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> azkar = [
      AppStrings.tasbeh1,
      AppStrings.tasbeh2,
      AppStrings.tasbeh3,
      AppStrings.tasbeh4,
      AppStrings.tasbeh5
    ];
    void onBodyTap(){
      counter++;
      if(counter % 33 == 0){
        index++;
      }
      if(index == azkar.length){
        index = 0;
      }
      setState(() {

      });
    }
    void onResetTap(){
      counter = 1;
      index = 0;
      setState(() {

      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.02),
          child: Center(
              child: Image.asset(AppAssets.islamiLogo, height: height * 0.25)),
        ),
        Text(AppStrings.mainTasbeeh,
            style: AppStyles.bold36White, textAlign: TextAlign.center),
        SizedBox(height: height * 0.02),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              AppAssets.sebhaHead,
              height: height * 0.07,
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.065),
              child: GestureDetector(
                onTap: onBodyTap,
                  child: Image.asset(AppAssets.sebhaBody, height: height * 0.4)),
            ),
            Positioned(
              top: height * 0.2,
              child: Column(
                children: [
                  Text(azkar[index], style: AppStyles.bold32White),
                  SizedBox(height: height * 0.01),
                  Text('$counter', style: AppStyles.bold32White)
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: height*0.01,left: width*0.75),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                onPressed: onResetTap, child: Text('Reset',style: AppStyles.bold16PrimaryDark)))
      ],
    );
  }
}
