import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_styles.dart';

class SebhaTab extends StatelessWidget {
  const SebhaTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int counter = 1;
    List<String> azkar = [
      'سبحان الله',
      'الحمد لله',
      'لا إله إلا الله',
      'الله أكبر',
      'لا حول ولا قوة إلا بالله'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: height*0.02),
          child: Center(child: Image.asset(AppAssets.islamiLogo,height: height*0.25)),
        ),
        Text('سَبِّحِ اسْمَ رَبِّكَ الأعلى',style: AppStyles.bold36White,textAlign: TextAlign.center),
        SizedBox(height: height*0.02),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(AppAssets.sebhaHead,height: height*0.08,),
            Padding(
              padding: EdgeInsets.only(top: height*0.08),
              child: Image.asset(AppAssets.sebhaBody,height: height*0.43),
            ),
            Positioned(
              top: height*0.22,
              child: Column(
                children: [
                  Text('سبحان الله',style: AppStyles.bold36White),
                  SizedBox(height: height*0.01),
                  Text('1',style: AppStyles.bold36White)
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
