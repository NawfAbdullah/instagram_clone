import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:instagram/components/single_post.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/models/story_mode.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/screens/data.dart';
import 'package:video_player/video_player.dart';

class StoryList extends StatefulWidget {
  StoryList({super.key, required this.stories});

  final List<Story> stories;

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late VideoPlayerController _videoPlayerController;
  late AnimationController _animationController;
  int _current_index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);
    final Story firstStory = widget.stories.first;
    _loadStory(
      story: firstStory,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (_current_index + 1 < widget.stories.length) {
            _current_index += 1;
            _loadStory(story: widget.stories[_current_index]);
          } else {
            _current_index = 0;
            _loadStory(story: widget.stories[_current_index]);
          }
        });
      }
    });
    _videoPlayerController =
        VideoPlayerController.network(widget.stories[2].url)
          ..initialize().then((value) => setState(() {}));

    _videoPlayerController.play();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _videoPlayerController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[_current_index];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapdown(details, story),
        child: Stack(children: [
          PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.stories.length,
              itemBuilder: (context, i) {
                final Story story = widget.stories[i];
                switch (story.media) {
                  case MediaType.image:
                    return CachedNetworkImage(
                      imageUrl: story.url,
                      fit: BoxFit.cover,
                    );
                  case MediaType.video:
                    if (_videoPlayerController != null &&
                        _videoPlayerController.value.isInitialized) {
                      return FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoPlayerController.value.size.width,
                          height: _videoPlayerController.value.size.height,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      );
                    }
                }
                return const SizedBox.shrink();
              }),
          Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Row(
                    children: widget.stories
                        .asMap()
                        .map(
                          (i, e) => MapEntry(
                            i,
                            AnimatedBar(
                              animationController: _animationController,
                              position: i,
                              currentIndex: _current_index,
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 10,
                    ),
                    child: UserInfo(user: story.user),
                  ),
                ],
              ))
        ]),
      ),
    );
  }

  void _onTapdown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_current_index - 1 >= 0) {
          _current_index -= 1;
          _loadStory(story: stories[0][_current_index]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_current_index + 1 < widget.stories.length) {
          _current_index += 1;
          _loadStory(story: stories[0][_current_index]);
        } else {
          _current_index = 0;
          _loadStory(story: stories[0][_current_index]);
        }
      });
    } else {
      if (story.media == MediaType.video) {
        if (_videoPlayerController.value.isPlaying) {
          _videoPlayerController.pause();
          _animationController.stop();
        } else {
          _videoPlayerController.play();
          // _loadStory(story: stories[_current_index]);
          _animationController.forward();
        }
      }
    }
  }

  void _loadStory({required Story story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    switch (story.media) {
      case MediaType.image:
        _animationController.duration = story.duration;
        _animationController.forward();
        break;
      case MediaType.video:
        // _videoPlayerController = null;
        _videoPlayerController?.dispose();
        _videoPlayerController = VideoPlayerController.network(story.url)
          ..initialize().then((value) {
            _animationController.duration =
                _videoPlayerController.value.duration;
            _videoPlayerController.play();
            _animationController.forward();
          });
        break;
    }

    if (animateToPage && _pageController.hasClients) {
      _pageController.animateToPage(_current_index,
          duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar(
      {super.key,
      required this.animationController,
      required this.position,
      required this.currentIndex});
  final AnimationController animationController;
  final int position;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5)),
              position == currentIndex
                  ? AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) => _buildContainer(
                          constraints.maxWidth * animationController.value,
                          Colors.white),
                    )
                  : SizedBox.shrink()
            ],
          );
        },
      ),
    ));
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: CachedNetworkImageProvider(
            user.profileImageUrl,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
