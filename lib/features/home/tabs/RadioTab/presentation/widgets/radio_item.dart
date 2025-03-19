import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/RadioTab/presentation/manager/radio_provider.dart';
import 'package:provider/provider.dart';

class RadioItem extends StatefulWidget {
  final String name;
  final String url;

  RadioItem({required this.name, required this.url});

  @override
  State<RadioItem> createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Consumer<RadioProvider>(
      builder: (context, provider, child) {
        final isCurrentPlaying = provider.isPlayingMap[widget.url] ?? false;
        final isVolumeUp = provider.getVolumeStatus(widget.url);

        return GestureDetector(
          onTap: () {
            provider.play(widget.url);
          },
          child: Container(
            height: height * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.primaryColor,
            ),
            child: Stack(
              children: [
                if (!isCurrentPlaying)
                  Positioned(
                    bottom: -5,
                    left: 0,
                    right: 0,
                    child: Image.asset(AppAssets.mosqueBg),
                  )
                else
                  Positioned(
                    bottom: -28,
                    left: -15,
                    right: -15,
                    child: Image.asset(AppAssets.wavesBg),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.name, style: AppStyles.bold20PrimaryDark),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.play(widget.url);
                          },
                          icon: Icon(
                            (provider.currentPlayingUrl == widget.url && provider.isPlaying)
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 35,
                            color: AppColors.primaryDarkColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (provider.currentPlayingUrl == widget.url) {
                              provider.stop();
                            }
                          },
                          icon: Icon(
                            Icons.stop,
                            size: 35,
                            color: AppColors.primaryDarkColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.setVolume(widget.url, !isVolumeUp); // تغيير حالة الصوت للرابط الحالي
                          },
                          icon: Icon(
                            isVolumeUp ? Icons.volume_up : Icons.volume_off,
                            size: 35,
                            color: AppColors.primaryDarkColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}