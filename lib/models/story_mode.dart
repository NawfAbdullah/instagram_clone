import 'package:faker/faker.dart';
import 'package:instagram/models/user_model.dart';

// class Story {
//   String profileUrl;
//   List<String> storyUrls;
//   bool isViewed;

//   Story({
//     required this.profileUrl,
//     required this.storyUrls,
//     this.isViewed = false,
//   });

//   List<Story> getStoriesList() {
//     List<Story> storyList = [];
//     for (var i = 0; i < 10; i++) {
//       Story story = Story(
//           profileUrl: faker.image.image(),
//           storyUrls: [faker.image.image(), faker.image.image()]);
//       storyList.add(story);
//     }
//     return storyList;
//   }
// }

enum MediaType { image, video }

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;
  Story(
      {required this.url,
      required this.media,
      required this.duration,
      required this.user});
}
