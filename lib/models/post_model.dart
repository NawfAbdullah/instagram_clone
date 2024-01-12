class Post {
  String username;
  String profile;
  String postUrl;
  int likes;
  bool isLiked;
  Post(
      {required this.username,
      required this.profile,
      required this.likes,
      required this.postUrl,
      this.isLiked = false});

  void toggleLiked() {
    isLiked = !isLiked;
  }
}
