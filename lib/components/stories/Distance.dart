import 'package:covivre/components/StoriesLib/StoryPage.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';

class Distance extends StatefulWidget {
  Distance({Key key}) : super(key: key);

  @override
  _DistanceState createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  final storyController = StoryController();
  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Distance/firstPage.png"),
        StoryItem.pageImage(
            controller: storyController,
            url: "lib/assets/img/Distance/secondPage.png")
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
