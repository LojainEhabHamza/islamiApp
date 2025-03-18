import 'package:flutter/material.dart';
import 'package:islami/core/api/api_manager/api_manager.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_strings.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/RadioTab/data/models/RadioResponseModel.dart';
import 'package:islami/features/home/tabs/RadioTab/data/models/RecitersResponseModel.dart';
import 'package:islami/features/home/tabs/RadioTab/presentation/widgets/radio_item.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.blackBgColor,
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelStyle: AppStyles.bold16PrimaryDark,
                      unselectedLabelStyle: AppStyles.regular16White,
                      tabs: const [
                        Tab(text: 'Radio'),
                        Tab(text: 'Reciters'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        FutureBuilder<RadioResponseModel>(
                            future: ApiManager.getRadioData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primaryColor));
                              } else if (snapshot.hasError) {
                                return Column(
                                  children: [
                                    Text(AppStrings.sthWentWrong,
                                        style: AppStyles.bold20Primary),
                                    TextButton(
                                        onPressed: () {
                                          ApiManager.getRadioData();
                                          setState(() {});
                                        },
                                        child: Text(AppStrings.tryAgain,
                                            style: AppStyles.bold20Primary))
                                  ],
                                );
                              }
                              RadioResponseModel data = snapshot.data!;
                              return ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: height * 0.02);
                                  },
                                  itemBuilder: (context, index) {
                                    return RadioItem(name: data.radios![index].name??'', url: data.radios![index].url??'');
                                  },
                                  itemCount: data.radios!.length);
                            }),
                        FutureBuilder<RecitersResponseModel>(
                            future: ApiManager.getRecitersData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primaryColor));
                              } else if (snapshot.hasError) {
                                return Column(
                                  children: [
                                    Text(AppStrings.sthWentWrong,
                                        style: AppStyles.bold20Primary),
                                    TextButton(
                                        onPressed: () {
                                          ApiManager.getRecitersData();
                                          setState(() {});
                                        },
                                        child: Text(AppStrings.tryAgain,
                                            style: AppStyles.bold20Primary))
                                  ],
                                );
                              }
                              RecitersResponseModel data = snapshot.data!;
                              return ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: height * 0.02);
                                  },
                                  itemBuilder: (context, index) {
                                    return RadioItem(name: data.reciters![index].name??'',url: '${data.reciters![index].moshaf![0].server}112.mp3');
                                  },
                                  itemCount: data.reciters!.length);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
