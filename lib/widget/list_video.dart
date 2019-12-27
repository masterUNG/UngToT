import 'dart:io';
import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ListVideo extends StatefulWidget {
  @override
  _ListVideoState createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  // Field
  bool status = false;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  // Method

  @override
  void initState() {
    super.initState();
    print('initState Work');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose Work');
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  Widget modePlayVideo() {
    String url = 'https://www.androidthai.in.th/tot/Video/video7582.mp4';
    videoPlayerController =
        VideoPlayerController.network(url);

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }

  Widget modeUpVideo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5 - 90,
      child: Stack(
        children: <Widget>[
          Center(
            child: RaisedButton.icon(
              icon: Icon(Icons.video_call),
              label: Text('Add Video'),
              onPressed: () {
                recordVideo();
              },
            ),
          ),
          showProcess(),
        ],
      ),
    );
  }

  Widget showProcess() {
    return status
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          )
        : SizedBox();
  }

  Future<void> recordVideo() async {
    await ImagePicker.pickVideo(source: ImageSource.camera).then((object) {
      uploadVideoToServer(object);
    });
  }

  Future<void> uploadVideoToServer(File file) async {
    setState(() {
      status = true;
    });

    String url = 'https://www.androidthai.in.th/tot/saveVideo.php';

    Random random = Random();
    int i = random.nextInt(10000);
    String nameVideo = 'video$i.mp4';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, nameVideo);
      FormData formData = FormData.from(map);

      await Dio().post(url, data: formData).then((response) {
        print('response ===>>> $response');
        setState(() {
          status = false;
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          modePlayVideo(),
          modeUpVideo(),
        ],
      ),
    );
  }
}
