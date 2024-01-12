import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/post_model.dart';

class single_post extends StatefulWidget {
  Post post;
  single_post({super.key, required this.post});

  @override
  State<single_post> createState() => _single_postState();
}

class _single_postState extends State<single_post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.profile),
                  backgroundColor: Colors.white,
                  radius: 20,
                ),
              ),
              Text(widget.post.username)
            ],
          ),
          Image.network(widget.post.postUrl),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.post.toggleLiked();
                    });
                  },
                  icon: Icon(widget.post.isLiked
                      ? Icons.favorite
                      : Icons.favorite_outline)),
            ],
          )
        ],
      ),
    );
  }
}
