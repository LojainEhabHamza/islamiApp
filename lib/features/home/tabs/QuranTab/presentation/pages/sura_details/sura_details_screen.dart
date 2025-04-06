import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/QuranTab/data/models/sura_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var args = ModalRoute.of(context)?.settings.arguments as SuraModel;
    if(verses.isEmpty){
      loadSuraFiles(args.index);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(args.suraEnName,style: AppStyles.bold20Primary),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              color: AppColors.primaryDarkColor,
              child: Image.asset(AppAssets.quranHadeethBg,width: double.infinity,height: double.infinity,fit: BoxFit.fill)),
          Column(
            children: [
              SizedBox(height: height*0.03),
              Text(args.suraArName,style: AppStyles.bold24Primary),
              SizedBox(height: height*0.03),
              Expanded(
                child: verses.isEmpty?
                    Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
                :ListView.builder(
                  itemCount: verses.length,
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
                          child: Text('[${index+1}] ${verses[index]}',style: AppStyles.bold20Primary,textAlign: TextAlign.center,textDirection: TextDirection.ltr),
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

  void loadSuraFiles(int index) async {
    String suraContent = await rootBundle.loadString('assets/files/${index + 1}.txt');
    List<String> suraLines = suraContent.split('\n').map((line) => line.trim()).toList();
    while (suraLines.isNotEmpty && suraLines.last.isEmpty) {
      suraLines.removeLast();
    }
    verses = suraLines;
    setState(() {});
  }
}
