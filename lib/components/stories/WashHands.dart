import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import "package:story_view/story_view.dart";

class WashHands extends StatefulWidget {
  WashHands({Key key}) : super(key: key);

  @override
  _WashHandsState createState() => _WashHandsState();
}

class _WashHandsState extends State<WashHands> {
  final storyController = StoryController();
  String link;
  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<String> get _localFile async {
    final path = await _localPath;
    return '$path/lib/assets/img/firstPage.png';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }

  getValue() async {
    var value = await _localFile;
    print('$value');
    setState(() {
      this.link = value;
    });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        StoryItem.pageImage(
            controller: storyController, file: '${this.link}', url: null),
      ],
      onStoryShow: (s) {
        print("Showing a story");
      },
      onComplete: () {
        Navigator.pop(context);
      },
      progressPosition: ProgressPosition.top,
      repeat: false,
      controller: storyController,
    );
  }
}
