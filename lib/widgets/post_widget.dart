import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:rice_music_sharing/screen/profile_screen.dart';
import 'package:rice_music_sharing/widgets/post_action_button.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class PostWidget extends StatefulWidget {
  // will take in a usermodel in the future
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidget();
}

class _PostWidget extends State<PostWidget> {
  late Future<UserModel> currUser;
  String postUser = "bananalegend"; /* temporary username */

  UserModel temp = UserModel(
      netID: "jx29", displayName: "Vivian", userName: "Vivian", following: []);

  void navigateToUser(BuildContext context) async {
    currUser = fetchUser();
    final user = await currUser;
    // final user = temp;
    // request user from backend
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen(userModel: user)),
      );
    }
  }

  Future<UserModel> fetchUser() async {
    final response = await http.get(Uri.parse("$backendURL\\users\\$postUser"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // decode the response to be a user model
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceVariant,
          width: 1,
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
              GestureDetector(
                onTap: () {
                  navigateToUser(context);
                },
                child: Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://picsum.photos/250?image=9",
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "David shared to Will Rice College",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    "32 min ago",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              )
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
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.comment_outlined),
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
                "Liked by David, Will Rice College, and 2 others",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(
            text: 'David ',
            style: Theme.of(context).textTheme.labelLarge,
            children: <TextSpan>[
              TextSpan(
                text:
                    'I love this song! Throwback to the early 2000s. Anyone else miss Katy Perry? I love this song! Throwback to the early 2000s. Anyone else miss Katy Perry?',
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
            "View 2 comments",
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ),
    );
  }
}
