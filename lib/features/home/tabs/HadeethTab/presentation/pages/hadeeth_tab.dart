import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/config/app_routes.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/HadeethTab/data/models/hadeeth_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HadeethTab extends StatefulWidget {
  @override
  State<HadeethTab> createState() => _HadeethTabState();
}

class _HadeethTabState extends State<HadeethTab> {
  List<HadeethModel> hadeethList = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if(hadeethList.isEmpty){
      loadHadeethFiles();
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height*0.02),
          child: Center(child: Image.asset(AppAssets.islamiLogo,height: height*0.25)),
        ),
        hadeethList.isEmpty?
        Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
        :CarouselSlider.builder(
            options: CarouselOptions(
              height: height*0.6,
              viewportFraction: 0.65,
              enlargeCenterPage: true,
              enableInfiniteScroll: true
            ),
            itemCount: hadeethList.length,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                InkWell(
                onTap: (){
                    Navigator.of(context).pushNamed(AppRoutes.hadeethDetailsRoute,arguments: hadeethList[itemIndex]);
                },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.02),
                    decoration:BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(image: AssetImage(AppAssets.hadeethFrame),fit: BoxFit.fill),
                    ),
                    child: Column(
                      children: [
                        Text(hadeethList[itemIndex].title,style: AppStyles.bold20PrimaryDark,textAlign: TextAlign.center),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
                              child: Text(hadeethList[itemIndex].content.join(''),style: AppStyles.bold16PrimaryDark,textAlign: TextAlign.center),
                            )
                        )
                      ],
                    )
                  ),
                ),
          ),
      ],
    );
  }

  void loadHadeethFiles()async{
    for (int i = 1; i <= 50; i++) {
      String hadeethContent = await rootBundle.loadString('assets/files/h$i.txt');
      List<String> hadeethLines = hadeethContent.split('\n').map((line) => line.trim()).toList();
      while (hadeethLines.isNotEmpty && hadeethLines.last.isEmpty) {
        hadeethLines.removeLast();
      }
      String title = hadeethLines[0];
      hadeethLines.removeAt(0);
      HadeethModel hadeethModel = HadeethModel(title: title, content: hadeethLines);
      hadeethList.add(hadeethModel);
      setState(() {});
    }
  }
}
