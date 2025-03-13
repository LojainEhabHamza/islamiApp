import 'package:flutter/material.dart';
import 'package:islami/config/app_routes.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_strings.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/QuranTab/data/models/sura_model.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/widgets/custom_text_form_field.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/widgets/most_recent_sura_widget.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/widgets/sura_list_item.dart';

class QuranTab extends StatelessWidget {
  const QuranTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.025),
            child: Image.asset(AppAssets.islamiLogo, height: height * 0.25),
          ),
          CustomTextFormField(
              hintText: AppStrings.suraName,
              prefixIcon: Image.asset(AppAssets.searchIcon)),
          SizedBox(height: height * 0.02),
          Text(AppStrings.mostRecently, style: AppStyles.bold16White),
          SizedBox(height: height * 0.02),
          MostRecentSuraWidget(),
          SizedBox(height: height * 0.02),
          Text(AppStrings.surasList, style: AppStyles.bold16White),
          SizedBox(height: height * 0.01),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: AppColors.whiteColor,
                  thickness: 2,
                  indent: 32.5,
                  endIndent: 25.5,
                );
              },
              padding: EdgeInsets.zero,
              itemCount: SuraModel.numVersesList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(AppRoutes.suraDetailsRoute,
                      arguments: SuraModel.getSuraModel(index)
                    );
                  },
                  child: SuraListItem(
                    suraModel: SuraModel.getSuraModel(index),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
