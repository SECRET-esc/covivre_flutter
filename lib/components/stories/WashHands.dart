import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class WashHands extends StatefulWidget {
  WashHands({Key key}) : super(key: key);

  @override
  _WashHandsState createState() => _WashHandsState();
}

class _WashHandsState extends State<WashHands> {
  final storyController = StoryController();
  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        StoryItem.inlineImage(url: null, caption: null, controller: null),
        StoryItem.pageImage(
            url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
            caption: "Working with gifs",
            controller: storyController),
        StoryItem.pageImage(
          url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
          caption: "Hello, from the other side",
          controller: storyController,
        ),
        StoryItem.pageImage(
          url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
          caption: "Hello, from the other side2",
          controller: storyController,
        ),
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