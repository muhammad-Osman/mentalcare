import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/draggable_sheet.dart';
import 'package:mentalcaretoday/src/UI/widgets/music_container.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/services/audio_page_manager.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class SpecificMoodScreen extends StatefulWidget {
  const SpecificMoodScreen({Key? key}) : super(key: key);

  @override
  State<SpecificMoodScreen> createState() => _SpecificMoodScreenState();
}

class _SpecificMoodScreenState extends State<SpecificMoodScreen> {
  late final PageManager _pageManager;

  bool _checkboxAffirmation = false;
  bool _checkboxPlayLoop = false;

  int? _radioValue;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  _frequencyDialog(BuildContext context, StateSetter setState) {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Helper.dynamicWidth(context, 5)),
          topRight: Radius.circular(Helper.dynamicWidth(context, 5)),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              child: _frequencySheet(context, setState),
            ),
          ),
        );
      },
    );
  }

  _frequencySheet(BuildContext context, StateSetter setState) {
    return CustomDraggableScrollableSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Helper.dynamicWidth(context, 6),
                vertical: Helper.dynamicHeight(context, 2)),
            child: AppBarTextHeadLine(
              text: "Choose Frequency",
              fontFamily: R.fonts.ralewaySemiBold,
              color: R.color.dark_black,
              fontSize: 1.2,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Helper.dynamicWidth(context, 3),
            ),
            height: Helper.dynamicHeight(context, 40),
            width: Helper.dynamicWidth(context, 90),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: Helper.dynamicHeight(context, 1),
                  indent: Helper.dynamicWidth(context, 4),
                );
              },
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Transform.scale(
                      scale: Helper.dynamicFont(context, 0.1),
                      child: Radio(
                        value: index,
                        groupValue: _radioValue,
                        activeColor: R.color.buttonColorblue,
                        onChanged: (newValue) {
                          setState(() {
                            _radioValue = newValue as int;
                          });
                        },
                      ),
                    ),
                    TextWidget(
                      text: "456 Hz",
                      color: R.color.dark_black,
                      fontSize: 1.1,
                      fontFamily: R.fonts.latoRegular,
                    ),
                  ],
                );
              },
            ),
          ),
          Divider(
            height: Helper.dynamicHeight(context, 1),
            thickness: Helper.dynamicFont(context, 0.1),
          ),
        ],
      ),
    );
  }

  _affirmationDialog(BuildContext context, StateSetter setState) {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Helper.dynamicWidth(context, 5)),
          topRight: Radius.circular(Helper.dynamicWidth(context, 5)),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              child: _affirmationsSheet(context, setState),
            ),
          ),
        );
      },
    );
  }

  _affirmationsSheet(BuildContext context, StateSetter setState) {
    return CustomDraggableScrollableSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Helper.dynamicWidth(context, 6),
                vertical: Helper.dynamicHeight(context, 2)),
            child: AppBarTextHeadLine(
              text: "Your Recorded Affiramtions",
              fontFamily: R.fonts.ralewaySemiBold,
              color: R.color.dark_black,
              fontSize: 1.2,
              textAlign: TextAlign.start,
            ),
          ),
          Center(
            child: SizedBox(
              height: Helper.dynamicHeight(context, 25),
              width: Helper.dynamicWidth(context, 90),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: Helper.dynamicHeight(context, 1),
                  );
                },
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return MusicContainerWithTwoIcons(
                    text: "You are Good Enough & you are Good Enough & you ...",
                    onPressedMusic: () {},
                    onPressedCross: () {},
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Helper.dynamicWidth(context, 6),
            ),
            child: AppBarTextHeadLine(
              text: "Affiramtions",
              fontFamily: R.fonts.ralewaySemiBold,
              color: R.color.dark_black,
              fontSize: 1.2,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: Helper.dynamicHeight(context, 1),
          ),
          Center(
            child: SizedBox(
              height: Helper.dynamicHeight(context, 25),
              width: Helper.dynamicWidth(context, 90),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: Helper.dynamicHeight(context, 1),
                  );
                },
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return MusicContainerWithOneIcons(
                    text: "You are Good Enough & you are Good Enough & you ...",
                    onPressedMusic: () {},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: SizedBox(
          height: Helper.dynamicHeight(context, 35),
          width: Helper.dynamicWidth(context, 100),
          child: Stack(
            children: [
              Positioned(
                child: SizedBox(
                  width: Helper.dynamicWidth(context, 100),
                  height: Helper.dynamicHeight(context, 100),
                  child: Image.asset(
                    R.image.background,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 0.5),
                left: Helper.dynamicWidth(context, 37),
                child: SizedBox(
                  width: Helper.dynamicWidth(context, 100),
                  height: Helper.dynamicHeight(context, 25),
                  child: SvgPicture.asset(
                    R.image.leftCurve,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: Helper.dynamicWidth(context, 30),
                child: SizedBox(
                  width: Helper.dynamicWidth(context, 100),
                  height: Helper.dynamicHeight(context, 20),
                  child: SvgPicture.asset(
                    R.image.rightCurve,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 5),
                left: Helper.dynamicWidth(context, 3),
                child: BackArrowButton(
                  iconColor: R.color.white,
                  borderColor: R.color.white,
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 6),
                left: Helper.dynamicWidth(context, 30),
                child: AppBarTextHeadLine(
                  text: "Specific Mood",
                  fontSize: 2,
                  color: R.color.white,
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 20),
                left: Helper.dynamicWidth(context, 5),
                child: ButtonWithGradientBackgroundAndMultiIcons(
                  linearGradient: LinearGradient(
                    colors: [
                      R.color.white,
                      R.color.white,
                    ],
                  ),
                  text:
                      "I’m going to have a good Day I’m going to have a good Day",
                  color: R.color.dark_black,
                  onPressed: () => _affirmationDialog(context, setState),
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 28),
                left: Helper.dynamicWidth(context, 2),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      checkColor: R.color.white,
                      activeColor: R.color.buttonColorGreen,
                      side: BorderSide(color: R.color.white),
                      value: _checkboxAffirmation,
                      onChanged: (value) {
                        setState(() {
                          _checkboxAffirmation = !_checkboxAffirmation;
                        });
                      },
                    ),
                    TextWidget(
                      text: 'Affirmation',
                      color: R.color.white,
                    ),
                    SizedBox(
                      width: Helper.dynamicWidth(context, 25),
                    ),
                    Checkbox(
                      checkColor: R.color.white,
                      activeColor: R.color.buttonColorGreen,
                      side: BorderSide(color: R.color.white),
                      value: _checkboxPlayLoop,
                      onChanged: (value) async {
                        setState(() {
                          _checkboxPlayLoop = !_checkboxPlayLoop;
                        });
                        if (_checkboxPlayLoop) {
                          _pageManager.loop(LoopMode.one);
                        } else {
                          _pageManager.loop(LoopMode.off);
                        }
                      },
                    ),
                    TextWidget(
                      text: 'Play on loop',
                      color: R.color.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 35),
                left: Helper.dynamicWidth(context, 5),
                child: SizedBox(
                  width: Helper.dynamicWidth(context, 8),
                  height: Helper.dynamicHeight(context, 8),
                  child: SvgPicture.asset(
                    R.image.clock,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 35),
                left: Helper.dynamicWidth(context, 90),
                child: SizedBox(
                  width: Helper.dynamicWidth(context, 7),
                  height: Helper.dynamicHeight(context, 7),
                  child: SvgPicture.asset(
                    R.image.mic,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 40),
                left: Helper.dynamicWidth(context, 25),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Helper.dynamicFont(context, 13.5)),
                  child: Image.network(
                    "https://images.macrumors.com/t/vMbr05RQ60tz7V_zS5UEO9SbGR0=/1600x900/smart/article-new/2018/05/apple-music-note.jpg",
                    fit: BoxFit.cover,
                    // loadingBuilder: (BuildContext context, Widget child,
                    //     ImageChunkEvent? loadingProgress) {
                    //   if (loadingProgress == null) return child;
                    //   return Padding(
                    //     padding: EdgeInsets.all(Helper.dynamicFont(context, 1.5)),
                    //     child: SpinKitFadingCube(
                    //       color: const Color.fromRGBO(248, 45, 75, 1),
                    //       size: Helper.dynamicFont(context, 3.5),
                    //     ),
                    //   );
                    // },
                    width: Helper.dynamicWidth(context, 50),
                    height: Helper.dynamicWidth(context, 50),
                  ),
                ),
              ),
              Positioned(
                  top: Helper.dynamicHeight(context, 70),
                  // left: Helper.dynamicWidth(context, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Helper.dynamicWidth(context, 5),
                        ),
                        child: SizedBox(
                          width: Helper.dynamicWidth(context, 90),
                          child: ValueListenableBuilder<ProgressBarState>(
                            valueListenable: _pageManager.progressNotifier,
                            builder: (_, value, __) {
                              return ProgressBar(
                                progress: value.current,
                                buffered: value.buffered,
                                total: value.total,
                                onSeek: _pageManager.seek,
                                timeLabelTextStyle: TextStyle(
                                    fontFamily: R.fonts.latoRegular,
                                    fontSize: Helper.dynamicFont(context, 1)),
                                baseBarColor: R.color.white.withOpacity(0.8),
                                progressBarColor: R.color.white,
                                thumbColor: R.color.white,
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Helper.dynamicWidth(context, 5),
                        ),
                        child: Row(
                          children: [
                            // TextWidget(
                            //   text: Helper.formatTime(position),
                            //   color: R.color.white,
                            //   fontSize: 1.1,
                            //   fontFamily: R.fonts.latoRegular,
                            // ),
                            // SizedBox(
                            //   width: Helper.dynamicWidth(context, 70),
                            // ),
                            // TextWidget(
                            //   text: Helper.formatTime(duration),
                            //   color: R.color.white,
                            //   fontSize: 1.1,
                            //   fontFamily: R.fonts.latoRegular,
                            // )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Helper.dynamicWidth(context, 9),
                            height: Helper.dynamicHeight(context, 9),
                            child: InkWell(
                              onTap: () {
                                _frequencyDialog(context, setState);
                              },
                              child: SvgPicture.asset(
                                R.image.frequency,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Helper.dynamicWidth(context, 2),
                          ),
                          ValueListenableBuilder<ButtonState>(
                            valueListenable: _pageManager.buttonNotifier,
                            builder: (_, value, __) {
                              switch (value) {
                                case ButtonState.loading:
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: Helper.dynamicHeight(context, 4),
                                    height: Helper.dynamicHeight(context, 4),
                                    child: CircularProgressIndicator(
                                      color: R.color.white,
                                    ),
                                  );
                                case ButtonState.paused:
                                  return PlayButton(
                                    ontap: () => _pageManager.play(),
                                    icon: Icons.play_arrow_rounded,
                                  );
                                case ButtonState.playing:
                                  return PlayButton(
                                    ontap: () => _pageManager.pause(),
                                    icon: Icons.pause_rounded,
                                  );
                              }
                            },
                          ),
                          // IconButton(
                          //     onPressed: () async {
                          //       // final positione =
                          //       //     Duration(seconds: position.inSeconds - 15);
                          //       // if (positione > Duration.zero) {
                          //       //   await audioPlayer.seek(positione);
                          //       // }
                          //     },
                          //     icon: Icon(
                          //       Icons.fast_rewind_rounded,
                          //       color: R.color.white,
                          //     )),
                          // PlayButton(
                          //   ontap: () async {
                          //     // if (isPlaying) {
                          //     //   setState(() {
                          //     //     isPlaying = !isPlaying;
                          //     //   });
                          //     //   await audioPlayer.pause();
                          //     // } else {
                          //     //   setState(() {
                          //     //     isPlaying = !isPlaying;
                          //     //   });

                          //     //   await audioPlayer.play(
                          //     //       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3');
                          //     // }
                          //   },
                          //   isPlayButton: isPlaying,
                          // ),
                          // IconButton(
                          //     onPressed: () async {
                          //       // final positione =
                          //       //     Duration(seconds: position.inSeconds + 15);
                          //       // if (positione < duration) {
                          //       //   await audioPlayer.seek(positione);
                          //       // }
                          //     },
                          //     icon: Icon(
                          //       Icons.fast_forward_rounded,
                          //       color: R.color.white,
                          //     )),
                          // SizedBox(
                          //   width: Helper.dynamicWidth(context, 4),
                          // ),
                        ],
                      ),
                    ],
                  )),
              Positioned(
                top: Helper.dynamicHeight(context, 89),
                left: Helper.dynamicWidth(context, 5),
                child: SizedBox(
                  width: Helper.dynamicWidth(context, 9),
                  height: Helper.dynamicHeight(context, 9),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(usersScreen);
                    },
                    child: SvgPicture.asset(
                      R.image.addFriend,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Helper.dynamicHeight(context, 90),
                left: Helper.dynamicWidth(context, 90),
                child: SizedBox(
                  width: Helper.dynamicWidth(context, 7),
                  height: Helper.dynamicHeight(context, 7),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(conversationScreen);
                    },
                    child: SvgPicture.asset(
                      R.image.chat,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
