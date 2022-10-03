import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:record/record.dart';
//import 'package:record_mp3/record_mp3.dart';

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

/*  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _soundRecorder = FlutterSoundRecorder();
    openAudio();

    // sendRecording();
  }*/

  @override
  void initState() {
    _soundRecorder = FlutterSoundRecorder();
    openAudio();

    super.initState();
  }

  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await _soundRecorder?.openRecorder();
    _soundRecorder?.setSubscriptionDuration(const Duration(milliseconds: 500));
    isRecorderInit = true;
  }

  String? recordFilePath;

  int i = 0;
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.aac";
  }

  void sendRecording() async {
    var tempDir = await getTemporaryDirectory();
    var path = '${tempDir.path}/flutter_sound.aac';
    //recordFilePath = await getCurrentUrl(tempDir.path);
    if (!isRecorderInit) {
      return;
    }
    if (isRecording) {
      await _soundRecorder?.stopRecorder();
      print(recordFilePath);
      await _moodServices.addrecording(
          context: context,
          path: File(path),
          affirmationId: widget.affrimationId,
          name: _nameController.text);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      await _soundRecorder?.startRecorder(
        toFile: path,
      );
    }

    setState(() {
      isRecording = !isRecording;
    });
  }

  Future<String> getCurrentUrl(String url) async {
    if (Platform.isIOS) {
      String a = url.substring(url.indexOf("Documents/") + 10, url.length);
      Directory dir = await getApplicationDocumentsDirectory();
      a = "${dir.path}/$a/.aac";
      return a;
    } else {
      return url;
    }
  }

  Timer? _timer;
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
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    height: 35,
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
                /*  Padding(
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
                      onPressed: () {},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    height: 35,
                    child: ButtonWithGradientBackground(
                      linearGradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 255, 255, 1.0),
                          Color.fromRGBO(255, 255, 255, 1.0),
                        ],
                      ),
                      text: isRecording ? "Submit" : "Start",
                      color: const Color.fromRGBO(126, 194, 220, 1.0),
                      onPressed: () {
                        if (_addRecordingKey.currentState!.validate()) {
                          if (!isRecording) {
                            startTimer();
                          } else {
                            _timer!.cancel();
                          }
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

  /* Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }
*/
  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }
}
