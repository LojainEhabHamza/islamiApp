import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami/core/api/api_manager/api_manager.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_constants.dart';
import 'package:islami/core/utils/app_strings.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/core/utils/date_utils.dart';
import 'package:islami/features/home/tabs/TimeTab/data/models/PrayerResponseModel.dart';
import 'package:islami/features/home/tabs/TimeTab/presentation/widgets/azkar_tab_item.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  List<String> azkar = [
    AppStrings.azkar1,
    AppStrings.azkar2,
    AppStrings.azkar3,
    AppStrings.azkar4,
    AppStrings.azkar5,
    AppStrings.azkar6,
    AppStrings.azkar7,
    AppStrings.azkar8,
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                SizedBox(
                  width: double.infinity,
                  height: height * 0.4,
                  child: FutureBuilder(
                      future: ApiManager.getPrayerDate(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                              child:
                              CircularProgressIndicator(color: AppColors.primaryColor));
                        } else if (snapshot.hasError) {
                          return Column(
                            children: [
                              Text(AppStrings.sthWentWrong,
                                  style: AppStyles.bold20Primary),
                              ElevatedButton(
                                  onPressed: () {
                                    ApiManager.getPrayerDate();
                                    setState(() {});
                                  },
                                  child: Text(AppStrings.tryAgain,
                                      style: AppStyles.bold20Primary))
                            ],
                          );
                        }
                        PrayerResponseModel data = snapshot.data!;
                        Map<String, dynamic> prayerTimes =
                        data.data!.timings!.toJson();
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppAssets.prayerTimeBg))),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                  top: 30,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                          DateFormatter.formatGregorian(
                                              data.data!.date!.gregorian!),
                                          style: AppStyles.bold16White),
                                      Column(
                                        children: [
                                          AutoSizeText(AppStrings.prayTime,
                                              style: AppStyles.bold20PrimaryDark
                                                  .copyWith(
                                                  color:
                                                  AppColors.darkGold)),
                                          Text(
                                              data.data!.date!.gregorian!
                                                  .weekday!.en!,
                                              style: AppStyles
                                                  .bold20PrimaryDark)
                                        ],
                                      ),
                                      AutoSizeText(
                                          DateFormatter.formatHijri(
                                              data.data!.date!.hijri!),
                                          style: AppStyles.bold16White)
                                    ],
                                  )),
                              Column(
                                children: [
                                  SizedBox(height: height * 0.13),
                                  CarouselSlider.builder(
                                      itemCount: prayerTimes.length,
                                      itemBuilder:
                                          (context, index, realIndex) {
                                        return Container(
                                          width: width * 0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    AppColors.primaryDarkColor,
                                                    AppColors.darkGold
                                                  ])),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    bottom: height * 0.01),
                                                child: Text(
                                                    prayerTimes.keys
                                                        .elementAt(index),
                                                    style:
                                                    AppStyles.bold20White),
                                              ),
                                              Text(
                                                  TimeConverter.to12Hours(
                                                      prayerTimes.values
                                                          .elementAt(index)),
                                                  style: AppStyles.bold26White,
                                                  textAlign: TextAlign.center)
                                            ],
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                          height: height * 0.21,
                                          enlargeCenterPage: true,
                                          viewportFraction: 0.3,
                                          enlargeFactor: 0.15)),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(height: height * 0.02),
                Text(AppConstants.azkar, style: AppStyles.bold20White),
                SizedBox(height: height * 0.02),
                ListView.builder(
                  padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: azkar.length,
                    itemBuilder: (context, index) {
                      return AzkarTabItem(azkarType: azkar[index]);
                    }
                    ),
                SizedBox(height: height * 0.05),
              ],
            ),
          ],
        ),
      ),
    );
  }
}