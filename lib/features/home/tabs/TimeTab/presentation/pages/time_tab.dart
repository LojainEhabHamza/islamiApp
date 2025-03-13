import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_styles.dart';

class TimeTab extends StatelessWidget {
  const TimeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.025),
              child: Center(
                child: Image.asset(
                  AppAssets.islamiLogo,
                  height: height * 0.25,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppAssets.prayerTime),
                SizedBox(height: height*0.02),
                Text('Azkar', style: AppStyles.bold16White),
                SizedBox(height: height*0.02),
                Row(
                  children: [
                    Expanded(child: Image.asset(AppAssets.morningAzkar)),
                    SizedBox(width: width*0.03),
                    Expanded(child: Image.asset(AppAssets.eveningAzkar))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
