import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:chewie_example/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    super.key,
    this.title = 'Chewie Demo',
  });

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  int? bufferDelay;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  List<String> srcs = [
    "https://www.treefe.in/video_1725979416530825_0_dKbGnV7wCPCqbWB4.mp4",
    "https://www.treefe.in/video_1725519289224798_0_JTf8Q5ovZDqgSCcJ.mp4",
    "https://www.treefe.in/video_1728390696278373_0_mkCfbAEsvF6SvWGe.mp4",
    "https://www.treefe.in/video_1726913543848460_0_tqz9k7ujIekqSUwj.mp4",
    "https://www.treefe.in/video_1727962702007024_0_nUSat8Wn5OwQDlEq.mp4",
    "https://www.treefe.in/video_1727081419590442_0_mdt6U5bTRihjEkED.mp4",
    "https://www.treefe.in/video_1725961307474236_0_5uYPFkA9ER7M64ae.mp4",
    "https://www.treefe.in/video_1728132075819621_0_3Nz1m7y8qoVgvB2U.mp4",
    "https://www.treefe.in/video_1726922612182235_0_vrfykzRTP4c43M7G.mp4",
    "https://www.treefe.in/video_1727965216635177_0_dYHg8JkndfKB1Qcj.mp4",
    'https://www.treefe.in/video_1728053218511292_0_40jAv6nHnHgupECs.mp4',
    "https://www.treefe.in/video_1725966235451248_0_CCMZAjizu8TsaUsl.mp4",
    "https://www.treefe.in/video_1727080353303273_0_cYMRgRKyxNwIB1X0.mp4",
    "https://www.treefe.in/video_1726652000566755_0_buAq5AomTRKclAqb.mp4",
    "https://www.treefe.in/video_1725446629120499_0_k3pS8qeOcEII3o01.mp4",
    "https://www.treefe.in/video_1728124071571171_0_PDTwgK5SlbOZIz7u.mp4",
    "https://www.treefe.in/video_1726671468883984_0_V4dlc5j0EtJ6rioE.mp4",
    "https://www.treefe.in/video_1725979591893362_0_jc9aUftTgdnyfgHK.mp4",
    "https://www.treefe.in/video_1726667766414573_0_WTRTOGkiJWC30Rlu.mp4",
    "https://www.treefe.in/video_1726918827098260_0_wbgsDoFNumLxyMU2.mp4",
  ];

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex]));
    _videoPlayerController2 =
        VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex+1]));
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
    _createChewieController(_videoPlayerController1);
    setState(() {});
  }

  void _createChewieController(_videoPlayerController) {
  
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      // fullScreenByDefault: true,
      hideControlsTimer: const Duration(seconds: 1),
      // autoInitialize: true,
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    print('XXXXX toggle video\n');
    // await _videoPlayerController1.pause();
    _createChewieController(_videoPlayerController2);
    setState(() {});
    currPlayIndex += 1;
    print('XXXX currentIndex $currPlayIndex \n');
    if (currPlayIndex >= srcs.length) {
      currPlayIndex = 0;
    }
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex]));
    _videoPlayerController2 =
        VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex+1]));
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: AppTheme.light.copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {
            print('YYYYY index $index\n');
           print('XXXXX toggle video\n');
    _createChewieController(_videoPlayerController2);
    setState(() {});
    currPlayIndex += 1;
    print('XXXX currentIndex $currPlayIndex \n');
    if (currPlayIndex >= srcs.length) {
      currPlayIndex = 0;
    }
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex]));
    _videoPlayerController2 =
        VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex+1]));
      _videoPlayerController1.initialize();
      _videoPlayerController2.initialize();
          },
          itemBuilder: (context, index) {
            return _chewieController != null &&
                _chewieController!
                    .videoPlayerController.value.isInitialized
              ? Chewie(
                  controller: _chewieController!,
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Loading'),
                  ],
                );
          }
        ),
      ),
    );  
  }
}

