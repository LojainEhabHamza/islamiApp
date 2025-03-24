import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_strings.dart';
import 'package:islami/core/utils/app_styles.dart';

class MostRecentSuraWidget extends StatelessWidget {
  final Map<String, String> lastSura;

  const MostRecentSuraWidget({
    Key? key,
    required this.lastSura,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.005),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: lastSura.isNotEmpty
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lastSura['suraEnName'] ?? '',
                  style: AppStyles.bold24PrimaryDark),
              SizedBox(height: height * 0.01),
              Text(lastSura['suraArName'] ?? '',
                  style: AppStyles.bold24PrimaryDark),
              SizedBox(height: height * 0.01),
              Text('${lastSura['numVerses'] ?? ''} Verses',
                  style: AppStyles.bold14PrimaryDark),
            ],
          ),
          Image.asset(AppAssets.mostRecentSura)
        ],
      )
          : Center(
        child: Text(
          AppStrings.nthToShow,
          style: AppStyles.bold24PrimaryDark,
        ),
      ),
    );
  }
}