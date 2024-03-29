import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/draggable_sheet.dart';
import 'package:mentalcaretoday/src/UI/widgets/music_container.dart';
import 'package:mentalcaretoday/src/UI/widgets/recording_dialog.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/services/audio_page_manager.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';

import 'package:shimmer/shimmer.dart';

import '../../models/single_music.dart';
import '../../provider/user_provider.dart';
import '../../services/afrimation_page_manger.dart';
import '../../services/mood_services.dart';

class SpecificMoodScreen extends StatefulWidget {
  final int id;

  const SpecificMoodScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<SpecificMoodScreen> createState() => _SpecificMoodScreenState();
}

class _SpecificMoodScreenState extends State<SpecificMoodScreen> {
  late PageManager _pageManager;
  late AfrimationPageManger afrimationPageManger;

  bool _checkboxAffirmation = false;
  bool _checkboxPlayLoop = false;

  int? _radioValue;

  @override
  void initState() {
    super.initState();

    afrimationPageManger = AfrimationPageManger();
    fetchMoods();
    // recorder.init();
  }

  bool isRecorderInit = false;
  bool isShow = false;
  int selectIndex = 0;
  int recordedSelectedIndex = 0;
  bool isRecording = false;
  bool isRecordedValue = false;
  FocusNode focusNode = FocusNode();
  final MoodServices _moodServices = MoodServices();
  // final recorder = SoundRecorder();
  SingleMusic? _singleMusic;
  bool isLoading = false;
  void fetchMoods() async {
    setState(() {
      isLoading = true;
    });
    _singleMusic = await _moodServices.getSingleMusic(context, widget.id);
    _pageManager = PageManager(_singleMusic!.music!.path!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageManager.dispose();
    afrimationPageManger.dispose();
    super.dispose();
    // recorder.dispose();
  }

  _frequencyDialog(
    BuildContext context,
  ) {
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
              child: _frequencySheet(
                context,
              ),
            ),
          ),
        );
      },
    );
  }

  _frequencySheet(
    BuildContext context,
  ) {
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
              itemCount: _singleMusic!.frequencies!.length,
              itemBuilder: (context, index) {
                final frequencyData = _singleMusic!.frequencies![index];
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
                      text: frequencyData.frequency,
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
              child: _affirmationsSheet(
                context,
              ),
            ),
          ),
        );
      },
    );
  }

  _affirmationsSheet(
    BuildContext context,
  ) {
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
              child: _singleMusic!.recordings!.isEmpty
                  ? const Center(child: Text("Not Found"))
                  : ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Helper.dynamicHeight(context, 1),
                        );
                      },
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _singleMusic!.recordings!.length,
                      itemBuilder: (context, index) {
                        return MusicContainerWithTwoIcons(
                          text: _singleMusic!.recordings![index].name!,
                          onPressedMusic: () {
                            setState(() {
                              recordedSelectedIndex = index;
                              isRecordedValue = true;
                              isShow = true;
                            });
                            if (_checkboxAffirmation) {
                              afrimationPageManger.setURl(isRecordedValue
                                  ? _singleMusic!
                                      .recordings![recordedSelectedIndex].path!
                                  : _singleMusic!
                                      .affirmations![selectIndex].path!);
                              afrimationPageManger.play();
                            }
                            Navigator.of(context).pop();
                          },
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
                itemCount: _singleMusic!.affirmations!.length,
                itemBuilder: (context, index) {
                  return MusicContainerWithOneIcons(
                    text: _singleMusic!.affirmations![index].title!,
                    onPressedMusic: () {
                      setState(() {
                        selectIndex = index;
                        isRecordedValue = false;
                        isShow = true;
                      });
                      if (_checkboxAffirmation) {
                        afrimationPageManger.setURl(isRecordedValue
                            ? _singleMusic!
                                .recordings![recordedSelectedIndex].path!
                            : _singleMusic!.affirmations![selectIndex].path!);
                        afrimationPageManger.play();
                      }
                      Navigator.of(context).pop();
                    },
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
    // final isRecording = recorder.isRecording;
    var userProvider = Provider.of<UserProvider>(
      context,
    );
    print(selectIndex);
    return Scaffold(
      body: SizedBox(
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: isLoading
            ? MoodShimer()
            : SizedBox(
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
                        icon: _checkboxAffirmation
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        linearGradient: LinearGradient(
                          colors: [
                            R.color.white,
                            R.color.white,
                          ],
                        ),
                        text: isShow
                            ? isRecordedValue
                                ? _singleMusic!
                                    .recordings![recordedSelectedIndex].name!
                                : _singleMusic!
                                    .affirmations![selectIndex].title!
                            : _singleMusic?.affirmations![0].title ?? "",
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
                              if (_checkboxAffirmation) {
                                afrimationPageManger.setURl(isRecordedValue
                                    ? _singleMusic!
                                        .recordings![recordedSelectedIndex]
                                        .path!
                                    : _singleMusic!
                                        .affirmations![selectIndex].path!);
                                afrimationPageManger.play();
                              } else {
                                afrimationPageManger.pause();
                              }
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
                      child: !userProvider.user.premium!
                          ? GestureDetector(
                              onTap: () async {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return RecordingDialog(
                                        affrimationId:
                                            _singleMusic!.music!.musicId!,
                                      );
                                    });
                                // if (isRecording) {
                                //   await stopRecord();
                                //   play();
                                // } else {
                                //   startRecord();
                                // }
                                // setState(() {
                                //   isRecording = !isRecording;
                                // });
                                // recordAudio();
                              },
                              child: SizedBox(
                                width: Helper.dynamicWidth(context, 7),
                                height: Helper.dynamicHeight(context, 7),
                                child: isRecording
                                    ? const Icon(Icons.pause)
                                    : SvgPicture.asset(
                                        R.image.mic,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                Fluttertoast.showToast(
                                    msg: "Please Purchase Subcription",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: const Color.fromRGBO(
                                        126, 194, 220, 1.0),
                                    textColor: Colors.white,
                                    fontSize: 12.0);
                              },
                              child: SizedBox(
                                width: Helper.dynamicWidth(context, 7),
                                height: Helper.dynamicHeight(context, 7),
                                child: SvgPicture.asset(
                                  R.image.mic,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      top: Helper.dynamicHeight(context, 40),
                      left: Helper.dynamicWidth(context, 25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Helper.dynamicFont(context, 13.5)),
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
                                  valueListenable:
                                      _pageManager.progressNotifier,
                                  builder: (_, value, __) {
                                    return ProgressBar(
                                      progress: value.current,
                                      buffered: value.buffered,
                                      total: value.total,
                                      onSeek: _pageManager.seek,
                                      timeLabelTextStyle: TextStyle(
                                          fontFamily: R.fonts.latoRegular,
                                          fontSize:
                                              Helper.dynamicFont(context, 1)),
                                      baseBarColor:
                                          R.color.white.withOpacity(0.8),
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
                                children: const [],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: Helper.dynamicWidth(context, 9),
                                  height: Helper.dynamicHeight(context, 9),
                                  child: InkWell(
                                    onTap: () {
                                      _frequencyDialog(
                                        context,
                                      );
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
                                          width:
                                              Helper.dynamicHeight(context, 4),
                                          height:
                                              Helper.dynamicHeight(context, 4),
                                          child: CircularProgressIndicator(
                                            color: R.color.white,
                                          ),
                                        );
                                      case ButtonState.paused:
                                        return PlayButton(
                                          ontap: () {
                                            _pageManager.play();
                                          },
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
                            _pageManager.pause();
                            afrimationPageManger.pause();
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
                            _pageManager.pause();
                            afrimationPageManger.pause();
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

class MoodShimer extends StatelessWidget {
  const MoodShimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Helper.dynamicHeight(context, 35),
      width: Helper.dynamicWidth(context, 100),
      child: Stack(children: [
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
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade300,
              child: Container(
                height: Helper.dynamicHeight(context, 6),
                width: Helper.dynamicHeight(context, 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Helper.dynamicFont(context, 10),
                    ),
                  ),
                ),
              ),
            )),
        Positioned(
            top: Helper.dynamicHeight(context, 6),
            left: Helper.dynamicWidth(context, 30),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade300,
              child: Container(
                height: 20,
                width: 200,
                color: Colors.grey.shade400,
              ),
            )),
        Positioned(
            top: Helper.dynamicHeight(context, 20),
            left: Helper.dynamicWidth(context, 5),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade300,
              child: Container(
                height: Helper.dynamicHeight(context, 7.5),
                width: Helper.dynamicWidth(context, 90),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                  borderRadius:
                      BorderRadius.circular(Helper.dynamicFont(context, 30)),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Helper.dynamicFont(context, 30)),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius:
                        BorderRadius.circular(Helper.dynamicFont(context, 30)),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: Helper.dynamicWidth(context, 5),
                            ),
                            Container(
                              height: Helper.dynamicHeight(context, 4),
                              width: Helper.dynamicHeight(context, 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    Helper.dynamicFont(context, 10),
                                  ),
                                ),
                              ),
                              child: Text(""),
                            ),
                            SizedBox(
                              width: Helper.dynamicWidth(context, 20),
                            ),
                            Container(
                              height: 17,
                              width: 120,
                              color: Colors.grey.shade400,
                            ),
                            // SvgPicture.asset(
                            //   imagePath.toString(),
                            //   width: Helper.dynamicHeight(context, imagewidth),
                            //   height: Helper.dynamicHeight(context, imageHeight),
                            // ),

                            SizedBox(
                              width: Helper.dynamicWidth(context, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
        Positioned(
          top: Helper.dynamicHeight(context, 30),
          left: Helper.dynamicWidth(context, 6),
          child: Row(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade300,
                child: Container(
                  height: 25,
                  color: Colors.grey.shade400,
                  width: 100,
                ),
              ),
              SizedBox(
                width: Helper.dynamicWidth(context, 35),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade300,
                child: Container(
                  height: 25,
                  width: 100,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: Helper.dynamicHeight(context, 35),
          left: Helper.dynamicWidth(context, 5),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade300,
            child: Container(
              width: Helper.dynamicWidth(context, 8),
              height: Helper.dynamicHeight(context, 8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade400, shape: BoxShape.circle),
            ),
          ),
        ),
        Positioned(
          top: Helper.dynamicHeight(context, 35),
          left: Helper.dynamicWidth(context, 85),
          child: SizedBox(
            width: Helper.dynamicWidth(context, 8),
            height: Helper.dynamicHeight(context, 8),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade300,
              child: Container(
                width: Helper.dynamicWidth(context, 8),
                height: Helper.dynamicHeight(context, 8),
                decoration: BoxDecoration(
                    color: Colors.grey.shade400, shape: BoxShape.circle),
              ),
            ),
          ),
        ),
        Positioned(
          top: Helper.dynamicHeight(context, 40),
          left: Helper.dynamicWidth(context, 25),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade300,
            child: Container(
              width: Helper.dynamicWidth(context, 50),
              height: Helper.dynamicWidth(context, 50),
              decoration: BoxDecoration(
                  color: Colors.grey.shade400, shape: BoxShape.circle),
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
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      width: Helper.dynamicWidth(context, 90),
                      height: Helper.dynamicWidth(context, 3),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Helper.dynamicHeight(context, 1),
                ),
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade300,
                      child: Container(
                        width: Helper.dynamicWidth(context, 9),
                        height: Helper.dynamicWidth(context, 9),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle),
                      ),
                    ),
                    SizedBox(
                      width: Helper.dynamicWidth(context, 2),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade300,
                      child: Container(
                        width: Helper.dynamicWidth(context, 10),
                        height: Helper.dynamicWidth(context, 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        Positioned(
          top: Helper.dynamicHeight(context, 89),
          left: Helper.dynamicWidth(context, 5),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade300,
            child: Container(
              width: Helper.dynamicWidth(context, 7),
              height: Helper.dynamicWidth(context, 7),
              decoration: BoxDecoration(
                  color: Colors.grey.shade400, shape: BoxShape.circle),
            ),
          ),
        ),
        Positioned(
          top: Helper.dynamicHeight(context, 90),
          left: Helper.dynamicWidth(context, 85),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade300,
            child: Container(
              width: Helper.dynamicWidth(context, 7),
              height: Helper.dynamicWidth(context, 7),
              decoration: BoxDecoration(
                  color: Colors.grey.shade400, shape: BoxShape.circle),
            ),
          ),
        ),
      ]),
    );
  }
}
