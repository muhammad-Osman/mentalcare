import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/enums/message_enum.dart';
import '../../provider/user_provider.dart';
import '../../services/audio_page_manager.dart';
import '../../utils/constants.dart';
import '../../utils/helper_method.dart';
import 'buttons.dart';

class DisplayTextImageGIF extends StatefulWidget {
  final String message;
  final String messageSenderId;
  final MessageEnum type;
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
    required this.messageSenderId,
  }) : super(key: key);

  @override
  State<DisplayTextImageGIF> createState() => _DisplayTextImageGIFState();
}

class _DisplayTextImageGIFState extends State<DisplayTextImageGIF> {
  late PageManager _pageManager;
  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    var currentUser = Provider.of<UserProvider>(
      context,
    ).user;
    return widget.type == MessageEnum.text
        ? Text(
            widget.message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : widget.type == MessageEnum.audio
            ? Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x804B66EA)),
                child: Row(
                  children: [
                    widget.messageSenderId == currentUser.id.toString()
                        ? const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 15,
                            child: Icon(Icons.person),
                          )
                        : SizedBox.shrink(),
                    const SizedBox(
                      width: 10,
                    ),
                    ValueListenableBuilder<ButtonState>(
                      valueListenable: _pageManager.buttonNotifier,
                      builder: (_, value, __) {
                        switch (value) {
                          case ButtonState.loading:
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              width: Helper.dynamicHeight(context, 2),
                              height: Helper.dynamicHeight(context, 2),
                              child: CircularProgressIndicator(
                                color: R.color.white,
                              ),
                            );
                          case ButtonState.paused:
                            return GestureDetector(
                              onTap: () {
                                _pageManager.setURL(widget.message);
                                _pageManager.play();
                              },
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                size: 30,
                              ),
                            );
                          case ButtonState.playing:
                            return GestureDetector(
                              onTap: () => _pageManager.pause(),
                              child: const Icon(
                                Icons.pause_rounded,
                                size: 30,
                              ),
                            );
                        }
                      },
                    ),
                    Expanded(
                      child: ValueListenableBuilder<ProgressBarState>(
                        valueListenable: _pageManager.progressNotifier,
                        builder: (_, value, __) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ProgressBar(
                                barHeight: 10,
                                progress: value.current,
                                buffered: value.buffered,
                                total: value.total,
                                onSeek: _pageManager.seek,
                                timeLabelTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: R.fonts.latoRegular,
                                    fontSize: Helper.dynamicFont(context, 1)),
                                baseBarColor: Color(0x704B66EA),
                                progressBarColor: Colors.white,
                                thumbColor: Colors.white),
                          );
                        },
                      ),
                    ),
                    widget.messageSenderId == currentUser.id.toString()
                        ? SizedBox.shrink()
                        : const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 15,
                            child: Icon(Icons.person),
                          ),
                  ],
                ),
              )
            : CachedNetworkImage(
                imageUrl: widget.message,
              );
  }
}
