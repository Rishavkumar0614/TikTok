import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';
import 'package:tiktok/controllers/video_upload_controller.dart';

class MobileConfirmVideoScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const MobileConfirmVideoScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<MobileConfirmVideoScreen> createState() =>
      MobileConfirmVideoScreenState();
}

class MobileConfirmVideoScreenState extends State<MobileConfirmVideoScreen> {
  Widget? buttonContent;
  late VideoPlayerController controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  VideoUploadController videoUploadController =
      Get.put(VideoUploadController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 1.5),
              child: VideoPlayer(controller),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: (MediaQuery.of(context).size.width - 20),
                    child: TextInputField(
                      icon: Icons.music_note,
                      labelText: 'Song Name',
                      controller: _songController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: (MediaQuery.of(context).size.width - 20),
                    child: TextInputField(
                      labelText: 'Caption',
                      icon: Icons.closed_caption,
                      controller: _captionController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      buttonContent = Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        width: (MediaQuery.of(context).size.width * 0.1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: const CircularProgressIndicator(),
                      );
                      setState(() {});
                      await videoUploadController.uploadVideo(
                          _songController.text,
                          _captionController.text,
                          widget.videoPath);
                      buttonContent = null;
                      setState(() {});
                    },
                    child: (buttonContent != null)
                        ? buttonContent
                        : const Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
