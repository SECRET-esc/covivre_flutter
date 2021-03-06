import 'package:covivre/components/StoriesLib/StoryPage.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';

class WashHands extends StatefulWidget {
  WashHands({Key key}) : super(key: key);

  @override
  _WashHandsState createState() => _WashHandsState();
}

class _WashHandsState extends State<WashHands> {
  final storyController = StoryController();
  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/WashHands/firstPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/WashHands/secondPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/WashHands/thirdPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/WashHands/fourthPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/WashHands/fifthPage.png"),
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
