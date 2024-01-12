import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:instagram/components/single_post.dart';
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
    return StoryList(stories: stories);
    // return ListView.builder(
    //   itemBuilder: (context, index) => single_post(post: posts[index]),
    //   itemCount: posts.length,
    // );
  }
}
