import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';

class RecitersItem extends StatefulWidget {
  @override
  State<RecitersItem> createState() => _RecitersItemState();
}

class _RecitersItemState extends State<RecitersItem> {
  bool isFavorite = false;

  bool isPlay = true;

  bool isVolumeUp = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryColor,
      ),
      child: Stack(
        children: [
          isPlay
              ? Positioned(
                  bottom: -5,
                  left: 0,
                  right: 0,
                  child: Image.asset(AppAssets.mosqueBg))
              : Positioned(
                  bottom: -28,
                  left: -15,
                  right: -15,
                  child: Image.asset(AppAssets.wavesBg)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Ibrahim Al-Akdar',
                  style: AppStyles.bold20PrimaryDark),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        isFavorite = !isFavorite;
                        setState(() {

                        });
                      },
                      icon: Icon(isFavorite?Icons.favorite_border:Icons.favorite,
                          size: 35, color: AppColors.primaryDarkColor)),
                  IconButton(
                      onPressed: () {
                        isPlay = !isPlay;
                        setState(() {});
                      },
                      icon: Icon( isPlay?Icons.play_arrow:Icons.pause,
                          size: 35, color: AppColors.primaryDarkColor)),
                  IconButton(
                      onPressed: () {
                        isVolumeUp = !isVolumeUp;
                        setState(() {

                        });
                      },
                      icon: Icon(isVolumeUp?Icons.volume_up:Icons.volume_off,
                          size: 35, color: AppColors.primaryDarkColor))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
