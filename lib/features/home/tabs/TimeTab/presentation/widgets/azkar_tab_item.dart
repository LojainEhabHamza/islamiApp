import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/TimeTab/presentation/manager/azkar_provider.dart';
import 'package:islami/features/home/tabs/TimeTab/presentation/pages/azkar_details_screen.dart';
import 'package:provider/provider.dart';

class AzkarTabItem extends StatelessWidget {
  String azkarType;
  AzkarTabItem({required this.azkarType});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Provider.of<AzkarProvider>(context, listen: false)
            .setSelectedAzkarType(azkarType);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AzkarDetailsScreen()),
        );
      },
      child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          height: height * 0.1,
          width: width * 0.3,
          decoration: BoxDecoration(
            color: AppColors.primaryDarkColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primaryColor, width: 2),
          ),
          child: Center(
              child: AutoSizeText(azkarType,
                  style: AppStyles.bold26White,
                  textAlign: TextAlign.center,
                  maxLines: 2))),
    );
  }
}
