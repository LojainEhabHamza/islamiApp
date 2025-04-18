import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_assets.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';
import 'package:islami/features/home/tabs/RadioTab/data/models/RecitersResponseModel.dart';
import 'package:islami/features/home/tabs/RadioTab/presentation/manager/radio_provider.dart';
import 'package:provider/provider.dart';

class SuraListScreen extends StatefulWidget {
  final Reciters reciter;

  SuraListScreen({required this.reciter});

  @override
  State<SuraListScreen> createState() => _SuraListScreenState();
}

class _SuraListScreenState extends State<SuraListScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      appBar: AppBar(
        title: Text(widget.reciter.name ?? '', style: AppStyles.bold20Primary),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: height * 0.02);
        },
        itemBuilder: (context, index) {
          final surahNumber = index + 1;
          final url = '${widget.reciter.moshaf![0].server}$surahNumber.mp3';

          return Consumer<RadioProvider>(
            builder: (context, provider, child) {
              final isCurrentPlaying = provider.isPlayingMap[url] ?? false;
              final isVolumeUp = provider.getVolumeStatus(url);
              final isPlaying = provider.isPlaying && provider.currentPlayingUrl == url;

              return GestureDetector(
                onTap: () {
                  provider.play(url);
                },
                child: Container(
                  height: height * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryColor,
                  ),
                  child: Stack(
                    children: [
                      if (isPlaying)
                        Positioned(
                          bottom: -28,
                          left: -15,
                          right: -15,
                          child: Image.asset(AppAssets.wavesBg),
                        )
                      else
                        Positioned(
                          bottom: -5,
                          left: 0,
                          right: 0,
                          child: Image.asset(AppAssets.mosqueBg),
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('سورة $surahNumber', style: AppStyles.bold20PrimaryDark),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.play(url);
                                },
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 35,
                                  color: AppColors.primaryDarkColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (provider.currentPlayingUrl == url) {
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
                                  provider.setVolume(url, !isVolumeUp);
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
        },
        itemCount: widget.reciter.moshaf![0].surahTotal?.toInt() ?? 0,
      ),
    );
  }
}