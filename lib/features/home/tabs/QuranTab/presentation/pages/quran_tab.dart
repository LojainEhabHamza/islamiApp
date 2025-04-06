import 'package:flutter/material.dart';
import 'package:islami/config/app_routes.dart';
import 'package:islami/core/cache/shared_preference_utils.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_strings.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/QuranTab/data/models/sura_model.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/widgets/custom_text_form_field.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/widgets/most_recent_sura_widget.dart';
import 'package:islami/features/home/tabs/QuranTab/presentation/widgets/sura_list_item.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  void addSuraList() {
    for (int i = 0; i < 114; i++) {
      SuraModel.suraList.add(SuraModel(
          suraEnName: SuraModel.suraEnNameList[i],
          suraArName: SuraModel.suraArNameList[i],
          numVerses: SuraModel.numVersesList[i],
          index: i));
    }
  }

  @override
  void initState() {
    super.initState();
    addSuraList();
    loadLastSura();
  }

  List<SuraModel> filteredList = SuraModel.suraList;
  String searchText = '';
  Map<String, String> lastSura = {};

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.025),
              child: Image.asset(
                AppAssets.islamiLogo,
                height: height * 0.25,
                fit: BoxFit.contain,
              ),
            ),
            CustomTextFormField(
              onChanged: (text) {
                searchText = text!;
                filteredList = SuraModel.suraList.where((sura) {
                  return sura.suraArName.contains(searchText) ||
                      sura.suraEnName
                          .toLowerCase()
                          .contains(searchText.toLowerCase());
                }).toList();
                setState(() {});
              },
              hintText: AppStrings.suraName,
              prefixIcon: Image.asset(AppAssets.searchIcon),
            ),
            SizedBox(height: height * 0.02),
            Text(AppStrings.mostRecently, style: AppStyles.bold16White),
            SizedBox(height: height * 0.02),
            if (searchText.isEmpty)
              MostRecentSuraWidget(lastSura: lastSura),
            SizedBox(height: height * 0.02),
            Text(AppStrings.surasList, style: AppStyles.bold16White),
            SizedBox(height: height * 0.01),
            ListView.separated(
              shrinkWrap: true,  // Important for nested ListView
              physics: NeverScrollableScrollPhysics(),  // Prevent nested scrolling
              padding: EdgeInsets.zero,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: AppColors.whiteColor,
                  thickness: 2,
                  indent: 32.5,
                  endIndent: 25.5,
                );
              },
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    saveLastSura(
                      suraEnName: filteredList[index].suraEnName,
                      suraArName: filteredList[index].suraArName,
                      numVerses: filteredList[index].numVerses,
                    );
                    Navigator.of(context).pushNamed(
                      AppRoutes.suraDetailsRoute,
                      arguments: filteredList[index],
                    );
                  },
                  child: SuraListItem(
                    suraModel: filteredList[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveLastSura({
    required String suraEnName,
    required String suraArName,
    required String numVerses,
  }) async {
    await SharedPreferenceUtils.saveData(key: 'suraEnName', value: suraEnName);
    await SharedPreferenceUtils.saveData(key: 'suraArName', value: suraArName);
    await SharedPreferenceUtils.saveData(key: 'numVerses', value: numVerses);
    await loadLastSura();
  }

  Future<Map<String, String>> getLastSura() async {
    return {
      'suraEnName': SharedPreferenceUtils.getData(key: 'suraEnName')?.toString() ?? '',
      'suraArName': SharedPreferenceUtils.getData(key: 'suraArName')?.toString() ?? '',
      'numVerses': SharedPreferenceUtils.getData(key: 'numVerses')?.toString() ?? '',
    };
  }

  loadLastSura() async {
    lastSura = await getLastSura();
    setState(() {});
  }
}