import 'dart:io';
import 'package:tiktok/commons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok/views/screens/mobile/confirm_video_screen.dart';

class MobileAddVideoScreen extends StatelessWidget {
  const MobileAddVideoScreen({super.key});

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () async {
              final video = await pickVideo(null);
              if (video != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MobileConfirmVideoScreen(
                      videoFile: File(video.path),
                      videoPath: video.path,
                    ),
                  ),
                );
              }
            },
            child: Row(
              children: [
                const Icon(Icons.image),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: GoogleFonts.ibmPlexSans(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              final video = await pickVideo(ImageSource.camera);
              if (video != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MobileConfirmVideoScreen(
                      videoFile: File(video.path),
                      videoPath: video.path,
                    ),
                  ),
                );
              }
            },
            child: Row(
              children: [
                const Icon(Icons.camera_alt),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    'Camera',
                    style: GoogleFonts.ibmPlexSans(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: [
                const Icon(Icons.cancel),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.ibmPlexSans(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double buttonWidth = (constraints.maxWidth * 0.4);
            double buttonHeight = (buttonWidth / 4);

            return InkWell(
              onTap: () => showOptionsDialog(context),
              child: Container(
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Add Video',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
