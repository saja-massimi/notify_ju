import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class MicInput extends StatefulWidget {
  @override
  _MicInputState createState() => _MicInputState();
}

class _MicInputState extends State<MicInput> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  @override
  void initState() {
    super.initState();
    _recorder.openAudioSession();
  }

  @override
  void dispose() {
    _recorder.closeAudioSession();
    super.dispose();
  }

  void _startRecording() async {
    await _recorder.startRecorder();
  }

  void _stopRecording() async {
    await _recorder.stopRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.mic),
          onPressed: _startRecording,
        ),
      const SizedBox(width: 20), 
        IconButton(
          icon: Icon(Icons.stop),
          onPressed: _stopRecording,
        ),
      ],
    );
  }
}
