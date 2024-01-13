import 'package:flutter/material.dart';
import 'package:instagram/components/story_list.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/screens/data.dart';

class Story extends StatelessWidget {
  User user;
  int index;
  Story({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(5),
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple,
              Colors.pink,
              Colors.orange,
            ],
          ),
          // color: color,
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryList(stories: stories[index]),
              )),
          child: Container(
            width: 95,
            height: 95,
            padding: const EdgeInsets.all(5),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: CircleAvatar(
              radius: 90,
              backgroundImage: NetworkImage(user.profileImageUrl),
            ),
          ),
        ));
  }
}
