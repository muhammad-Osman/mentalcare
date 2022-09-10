import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:record_mp3/record_mp3.dart';

import '../../services/auth_services.dart';
import '../../services/mood_services.dart';
import '../../utils/constants.dart';
import 'buttons.dart';
import 'input_field.dart';

class RecordingDialog extends StatefulWidget {
  final String affrimationId;
  const RecordingDialog({
    Key? key,
    required this.affrimationId,
  }) : super(key: key);

  @override
  State<RecordingDialog> createState() => _RecordingDialogState();
}

class _RecordingDialogState extends State<RecordingDialog> {
  final TextEditingController _nameController = TextEditingController();
  final AuthService _authService = AuthService();
  final MoodServices _moodServices = MoodServices();
  final _addRecordingKey = GlobalKey<FormState>();
  late ProgressDialog pr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = ProgressDialog(context);
    startTimer();
    startRecord();
  }

  void sendRecording() async {
    if (recordFilePath != null && File(recordFilePath!).existsSync()) {
      print(recordFilePath);
      setState(() {
        isLoading = true;
      });
      await _moodServices.addrecording(
          context: context,
          path: File(recordFilePath!),
          affirmationId: widget.affrimationId,
          name: _nameController.text);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(141, 227, 216, 1.0),
                Color.fromRGBO(126, 194, 220, 1.0),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _addRecordingKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'Add Your Affirmation',
                  color: R.color.white,
                  fontSize: 1.7,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  alignment: Alignment.center,
                  child: TextWidget(
                    text: "$_start",
                    color: R.color.white,
                    fontSize: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    height: 30,
                    child: TextFieldWithIcon(
                      isRecording: true,
                      onChanged: ((p0) {}),
                      controller: _nameController,
                      placeHolder: "Name",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    height: 30,
                    child: ButtonWithGradientBackground(
                      linearGradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 255, 255, 1.0),
                          Color.fromRGBO(255, 255, 255, 1.0),
                        ],
                      ),
                      text: "Stop Recording",
                      color: const Color.fromRGBO(126, 194, 220, 1.0),
                      onPressed: () {
                        _timer.cancel();
                        stopRecord();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: SizedBox(
                          height: 30,
                          child: ButtonWithGradientBackground(
                            isLoading: true,
                            text: "SIGN UP",
                            onPressed: () {},
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: SizedBox(
                          height: 30,
                          child: ButtonWithGradientBackground(
                            linearGradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 255, 255, 1.0),
                                Color.fromRGBO(255, 255, 255, 1.0),
                              ],
                            ),
                            text: "Submit",
                            color: const Color.fromRGBO(126, 194, 220, 1.0),
                            onPressed: () {
                              if (_addRecordingKey.currentState!.validate()) {
                                sendRecording();
                              }
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  late Timer _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _start++;
        });
      },
    );
  }

  String statusText = "";
  bool isComplete = false;
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  String? recordFilePath;

  Future startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  Future stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }
}
