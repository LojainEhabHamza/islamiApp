import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_constants.dart';
import 'package:islami/core/utils/app_strings.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/TimeTab/data/models/AzkarModel.dart';
import 'package:islami/features/home/tabs/TimeTab/presentation/manager/azkar_provider.dart';
import 'package:provider/provider.dart';

class AzkarDetailsScreen extends StatefulWidget {
  const AzkarDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AzkarDetailsScreen> createState() => _AzkarDetailsScreenState();
}

class _AzkarDetailsScreenState extends State<AzkarDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var azkarType = Provider.of<AzkarProvider>(context).selectedAzkarType;

    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      appBar: AppBar(
        title: Text(azkarType ?? AppConstants.azkar,style: AppStyles.bold24Primary),
        backgroundColor: AppColors.primaryDarkColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
        child: FutureBuilder(
          future: AzkarModel.loadAzkarModel(azkarType ?? AppConstants.azkar),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  Text(AppStrings.sthWentWrong, style: AppStyles.bold20Primary),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(AppStrings.tryAgain, style: AppStyles.bold20Primary),
                  ),
                ],
              );
            }
            final data = snapshot.data as List<AzkarModel>;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  height: height * 0.4,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDarkColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      data[index].content!,
                      style: AppStyles.bold32White,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}