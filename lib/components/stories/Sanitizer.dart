import 'package:covivre/components/StoriesLib/StoryPage.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';

class Sanitizer extends StatefulWidget {
  Sanitizer({Key key}) : super(key: key);

  @override
  _SanitizerState createState() => _SanitizerState();
}

class _SanitizerState extends State<Sanitizer> {
  final storyController = StoryController();
  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Sanitizer/firstPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Sanitizer/secondPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Sanitizer/thirdPage.png")
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
