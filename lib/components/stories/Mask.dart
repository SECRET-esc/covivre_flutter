import 'package:covivre/components/StoriesLib/StoryPage.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';

class Mask extends StatefulWidget {
  Mask({Key key}) : super(key: key);

  @override
  _MaskState createState() => _MaskState();
}

class _MaskState extends State<Mask> {
  final storyController = StoryController();
  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Mask/firstPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Mask/secondPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Mask/thirdPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Mask/fourthPage.png")
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
