import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/RadioTab/presentation/widgets/radio_item.dart';
import 'package:islami/features/home/tabs/RadioTab/presentation/widgets/reciters_item.dart';

class RadioTab extends StatelessWidget {
  const RadioTab({super.key});

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
                        ListView.separated(
                            separatorBuilder: (context,index) {
                              return SizedBox(height: height*0.02);
                            },
                            itemBuilder: (context, index) {
                              return RadioItem();
                            },
                            itemCount: 20
                        ),
                        ListView.separated(
                            separatorBuilder: (context,index) {
                              return SizedBox(height: height*0.02);
                            },
                            itemBuilder: (context, index) {
                              return RecitersItem();
                            },
                            itemCount: 20
                        ),
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
