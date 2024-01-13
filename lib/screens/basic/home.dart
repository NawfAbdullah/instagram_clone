import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:instagram/components/single_post.dart';
import 'package:instagram/components/story.dart';
import 'package:instagram/components/story_list.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/screens/data.dart';

class Home extends StatelessWidget {
  Home({super.key});
  List<Post> posts = [
    Post(
        username: faker.person.firstName(),
        profile: faker.image.image(),
        likes: 20,
        postUrl: faker.image.image()),
    Post(
        username: faker.person.firstName(),
        profile: faker.image.image(),
        likes: 20,
        postUrl: faker.image.image()),
    Post(
        username: faker.person.firstName(),
        profile: faker.image.image(),
        likes: 20,
        postUrl: faker.image.image()),
    Post(
        username: faker.person.firstName(),
        profile: faker.image.image(),
        likes: 20,
        postUrl: faker.image.image()),
    Post(
        username: faker.person.firstName(),
        profile: faker.image.image(),
        likes: 20,
        postUrl: faker.image.image()),
    Post(
        username: faker.person.firstName(),
        profile: faker.image.image(),
        likes: 20,
        postUrl: faker.image.image()),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) => Story(
              user: users[i],
              index: i,
            ),
            itemCount: users.length,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => single_post(post: posts[index]),
            itemCount: posts.length,
          ),
        ),
      ],
    );
  }
}
