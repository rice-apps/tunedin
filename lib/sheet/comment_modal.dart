import 'package:flutter/material.dart';
import 'package:rice_music_sharing/sheet/tunedin_bottom_sheet.dart';
import 'package:rice_music_sharing/widgets/comment.dart';

class CommentModal extends StatelessWidget {
  const CommentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return TunedInBottomSheet(
        builder: (sheetContext, pageContext, pushRoute) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Comment(
                      children: true,
                    ),
                  );
                }),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Theme.of(context).colorScheme.secondary,
                child: Row(children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage("https://picsum.photos/250?image=9"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: Theme.of(context).textTheme.displayMedium,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.secondary,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF45495C)),
                          borderRadius: BorderRadius.all(Radius.circular(64.0)),
                        ),
                        hintText: 'Add a comment...',
                      ),
                    ),
                  ),
                ]),
              )
            ],
          );
        },
        title: "Comment");
  }
}
