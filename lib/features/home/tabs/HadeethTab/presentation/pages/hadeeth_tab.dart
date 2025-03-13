import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Container(
      child: CarouselSlider.builder(
        options: CarouselOptions(),
        itemCount: hadeethList.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Container(
              decoration:BoxDecoration(
                image: DecorationImage(image: AssetImage(AppAssets.hadeethFrame)),
              ),
              child: hadeethList.isEmpty?
              CircularProgressIndicator():Text('')
            ),
      )
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
