import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';

class MostRecentSuraWidget extends StatelessWidget {
  const MostRecentSuraWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.symmetric(vertical: height*0.005),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Al-Anbiya',style: AppStyles.bold24PrimaryDark),
                SizedBox(height: height*0.01),
                Text('الأنبياء',style: AppStyles.bold24PrimaryDark),
                SizedBox(height: height*0.01),
                Text('112 Verses',style: AppStyles.bold14PrimaryDark),
              ],
            ),
            Image.asset(AppAssets.mostRecentSura)
          ],
        )
    );
  }
}
