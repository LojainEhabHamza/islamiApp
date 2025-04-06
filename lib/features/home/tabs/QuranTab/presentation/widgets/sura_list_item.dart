import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/QuranTab/data/models/sura_model.dart';

class SuraListItem extends StatelessWidget {
  SuraModel suraModel;
  SuraListItem({required this.suraModel});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAssets.suraNumberVector),
            Text('${suraModel.index+1}',style: AppStyles.bold16White)
          ],
        ),
        SizedBox(width: width*0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(suraModel.suraEnName,style: AppStyles.bold20White),
            SizedBox(height: height*0.005),
            Text('${suraModel.numVerses} verses',style: AppStyles.bold16White)
          ],
        ),
        Spacer(),
        Text(suraModel.suraArName,style: AppStyles.bold20White)
      ],
    );
  }
}
