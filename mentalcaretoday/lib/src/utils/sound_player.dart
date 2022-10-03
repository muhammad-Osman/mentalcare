// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_sound_lite/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../services/mood_services.dart';

// final pathToSaveFile = "test.aac";

// class SoundRecorder {
//   FlutterSoundRecorder? _recorder;
//   final MoodServices _moodServices = MoodServices();
//   bool _isRecorderInitialized = false;
//   bool get isRecording => _recorder!.isRecording;
//   Future init() async {
//     _recorder = FlutterSoundRecorder();
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException("microphone Permistion needed");
//     }
//     _recorder!.openAudioSession();
//     _isRecorderInitialized = true;
//   }

//   Future _record() async {
//     if (!_isRecorderInitialized) return;
//     await _recorder!.startRecorder(toFile: pathToSaveFile);
//   }

//   Future dispose() async {
//     if (!_isRecorderInitialized) return;
//     await _recorder!.closeAudioSession();
//     _recorder = null;
//     _isRecorderInitialized = false;
//   }

//   Future _stop(BuildContext context) async {
//     if (!_isRecorderInitialized) return;
//     final filePath = await _recorder!.stopRecorder();
//     print(filePath);
//     await _moodServices.addrecording(
//         context: context,
//         path: File(filePath!),
//         affirmationId: "3",
//         name: "Allah");
//   }

//   Future toggleRecording(BuildContext context) async {
//     if (_recorder!.isStopped) {
//       await _record();
//     } else {
//       await _stop(context);
//     }
//   }
// }
