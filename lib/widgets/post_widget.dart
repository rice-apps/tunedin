import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_stack/image_stack.dart';
import 'package:rice_music_sharing/data/models/post_model.dart';
import 'package:rice_music_sharing/widgets/post_action_button.dart';

// import '../controllers/post_controller.dart';
import '../data/models/user_model.dart';
import '../providers/post_provider.dart';

class PostWidget extends ConsumerWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // late PostController controller = PostController(ref);

    final post = PostModel(
        id: "",
        author: UserModel(name: "", netID: "", handle: "", token: ""),
        likedBy: [],
        comments: [],
        numLikes: 0,
        bodyText: "",
        musicURL: ""); //ref.watch(postStateProvider);

    // you can use functions such like
    // controller.likePost();
    // and then await them using like a future builder

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceVariant,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
                radius: 18,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${post.author.name} shared to Will Rice College",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    "32 min ago",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              Spacer(),
              Center(
                child: IconButton(
                  icon: Icon(Icons.delete_outline_rounded),
                  iconSize: 25,
                  color: Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {
                    // popup with msg
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Delete?',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          content: Text(
                            'Are you sure you want to delete this post?',
                            style: Theme.of(context).textTheme.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                            Size(
                                              100, 25
                                            ))
                                  ),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    // Handle button press
                                  },
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                            Size(
                                              100, 25
                                            ))
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    // Handle "Cancel" button press
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          elevation: 10,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const PostSongDetails(),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, size: 30),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.messenger_outline, size: 30),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ImageStack.widgets(
                widgetBorderColor: Colors.transparent,
                widgetBorderWidth: .5,
                widgetRadius: 20,
                totalCount: -1,
                children: const [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://picsum.photos/250?image=9"),
                  ),
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://picsum.photos/250?image=9"),
                  ),
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://picsum.photos/250?image=9"),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Liked by David and 35 others",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(
            text: '${post.author.name} ',
            style: Theme.of(context).textTheme.labelLarge,
            children: <TextSpan>[
              TextSpan(
                text: post.bodyText,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          )),
          const SizedBox(
            height: 10,
          ),
          Text(
            "View 4 comments",
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ),
    );
  }
}
