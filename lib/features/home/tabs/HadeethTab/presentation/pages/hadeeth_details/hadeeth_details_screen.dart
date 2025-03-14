import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/HadeethTab/data/models/hadeeth_model.dart';
import 'package:islami/features/home/tabs/QuranTab/data/models/sura_model.dart';

class HadeethDetailsScreen extends StatefulWidget {
  @override
  State<HadeethDetailsScreen> createState() => _HadeethDetailsScreenState();
}

class _HadeethDetailsScreenState extends State<HadeethDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var args = ModalRoute.of(context)?.settings.arguments as HadeethModel;

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              color: AppColors.primaryDarkColor,
              child: Image.asset(AppAssets.quranHadeethBg,width: double.infinity,height: double.infinity,fit: BoxFit.fill)),
          Column(
            children: [
              SizedBox(height: height*0.03),
              Text(args.title,style: AppStyles.bold24Primary),
              SizedBox(height: height*0.03),
              Expanded(
                child:ListView.builder(
                    itemCount: args.content.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.01),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.03),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Text(args.content[index],style: AppStyles.bold20Primary,textAlign: TextAlign.center,textDirection: TextDirection.ltr),
                        ),
                      );
                    }
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
