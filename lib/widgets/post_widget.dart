import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          ImageStack.widgets(
            widgetBorderColor: Colors.transparent,
            widgetBorderWidth: .5,
            widgetRadius: 30,
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
          const Text("David, Brian, and 2 others like"),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 350,
        height: 120,
        child: Row(
          children: [
            Image.network(
              "https://picsum.photos/250?image=9",
              width: 120,
              height: 120,
              fit: BoxFit.fill,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Teenage Dream",
                    ),
                    const SizedBox(height: 5),
                    const Text("Katy Perry"),
                    const SizedBox(height: 5),
                    Expanded(
                        child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.share_outlined),
                                  onPressed: () {}),
                              const Text("Share"),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.add_outlined),
                                  onPressed: () {}),
                              const Text("Add"),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.volume_up_outlined),
                                  onPressed: () {}),
                              const Text("Listen"),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.favorite_outline),
                                  onPressed: () {}),
                              const Text("Like"),
                            ],
                          ),
                        ])),
                  ],
                ))
          ],
        ),
      )
    ]);
  }
}
