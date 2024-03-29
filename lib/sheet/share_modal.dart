import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_music_sharing/sheet/tunedin_bottom_sheet.dart';

import '../controllers/post_controller.dart';

class ShareModal extends StatefulWidget {
  const ShareModal({super.key});

  @override
  ShareModalState createState() => ShareModalState();
}

class ShareModalState extends State<ShareModal> {
  GlobalKey<FormState> postFormKey = GlobalKey<FormState>();
  TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TunedInBottomSheet(
        builder: (sheetContext, pageContext, pushRoute) {
          return TargetPickerPage(
            sheetContext,
            pageContext,
            pushRoute,
            showSong: false,
            showSongSearchHeader: true,
            getTargetName: (index) => 'Song Name',
            getTargetIcon: (index) => const Icon(Icons.playlist_play),
            buildTargetPage: (index) => TargetPickerPage(
                sheetContext, pageContext, pushRoute,
                showShareASongHeader: true,
                getTargetIcon: (target) => DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color(0xFF45495C),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(0 == target ? Icons.person : Icons.group),
                    )),
                getTargetName: (target) =>
                    0 == target ? 'Your profile' : 'Group',
                maxCount: 2,
                showSearch: false,
                buildTargetPage: (int index) {
                  if (index == 1) {
                    return TargetPickerPage(
                      sheetContext,
                      pageContext,
                      pushRoute,
                      maxCount: 10,
                      showSearch: false,
                      showChooseGroupHeader: true,
                      getTargetName: (index) => 'Will Rice College',
                      getTargetIcon: (index) => const Icon(Icons.school),
                      buildTargetPage: (int index) {
                        return ShareCommentPage(
                            sheetContext, postFormKey, captionController);
                      },
                    );
                  } else {
                    return ShareCommentPage(
                        sheetContext, postFormKey, captionController);
                  }
                }),
          );
        },
        title: 'Profile');
  }
}

class TargetPickerPage extends StatefulWidget {
  final String Function(int index) getTargetName;
  final Widget Function(int index) getTargetIcon;
  final Widget Function(int index) buildTargetPage;
  final int? maxCount;
  final BuildContext sheetContext;
  final BuildContext pageContext;
  final PushRouteBuilder pushRoute;
  final bool showSearch;
  final bool showSong;
  final bool showSongSearchHeader;
  final bool showShareASongHeader;
  final bool showChooseGroupHeader;

  const TargetPickerPage(this.sheetContext, this.pageContext, this.pushRoute,
      {Key? key,
      required this.getTargetName,
      required this.getTargetIcon,
      this.maxCount,
      required this.buildTargetPage,
      this.showSearch = true,
      this.showSong = true,
      this.showSongSearchHeader = false,
      this.showShareASongHeader = false,
      this.showChooseGroupHeader = false})
      : super(key: key);

  @override
  State<TargetPickerPage> createState() => _TargetPickerPageState();
}

class _TargetPickerPageState extends State<TargetPickerPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showSongSearchHeader)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Search for a song",
                  style: Theme.of(context)
                      .textTheme
                      .apply(fontSizeFactor: 2.0)
                      .displayMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                )),
          ),
        if (widget.showShareASongHeader)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Share a song",
                  style: Theme.of(context)
                      .textTheme
                      .apply(fontSizeFactor: 2.0)
                      .displayMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                )),
          ),
        if (widget.showChooseGroupHeader)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose Group",
                  style: Theme.of(context)
                      .textTheme
                      .apply(fontSizeFactor: 2.0)
                      .displayMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                )),
          ),
        if (widget.showSong)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF969BB5), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    ClipRRect(
                      child: Image.network(
                        "https://picsum.photos/250?image=9",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Song Name",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                          Text("Artist",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  )),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        if (widget.showSearch)
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.displayMedium,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search Songs',
                hintStyle: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: const Color(0xFFA1A9BC)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFA1A9BC)),
                filled: true,
                fillColor: const Color(0xFF45495C),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Color(0xFF969BB5), width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Color(0xFF303449), width: 1),
                ),
              ),
            ),
          ),
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.maxCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: ListTile(
                      title: Text(
                        widget.getTargetName(index),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      leading: widget.getTargetIcon(index),
                      // song/group select
                      trailing: Radio(
                        value: index,
                        groupValue: _selectedIndex,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedIndex = value;
                            });
                          }
                        },
                      ),
                    ),
                  );
                })),
        KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            if (!isKeyboardVisible) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: const Border(
                    top: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: ElevatedButton(
                  onPressed: () {
                    widget.pushRoute(
                      pageContext: widget.pageContext,
                      sheetContext: widget.sheetContext,
                      title: "Share",
                      child: widget.buildTargetPage(_selectedIndex),
                    );
                  },
                  child: const Text('Next'),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class ShareCommentPage extends ConsumerWidget {
  final BuildContext sheetContext;
  final GlobalKey<FormState> postFormKey;
  final TextEditingController captionController;

  const ShareCommentPage(
      this.sheetContext, this.postFormKey, this.captionController,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late PostController controller = PostController(ref);
    return Form(
        key: postFormKey,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add caption",
                  style: Theme.of(context)
                      .textTheme
                      .apply(fontSizeFactor: 2.0)
                      .displayMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF969BB5), width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            ClipRRect(
                              // borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                "https://picsum.photos/250?image=9",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Song Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          )),
                                  Text("Artist",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          )),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                        controller: captionController,
                        style: Theme.of(context).textTheme.displaySmall,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        maxLength: 1000,
                        decoration: InputDecoration(
                            counterStyle:
                                Theme.of(context).textTheme.displaySmall,
                            hintText: 'Add caption...',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: const Color(0xFF969BB5))),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                  ),
                ],
              ),
            ),
          ),
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            if (!isKeyboardVisible) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: const Border(
                    top: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: ElevatedButton(
                  onPressed: () {
                    final form = postFormKey.currentState!;
                    if (form.validate()) {
                      controller.createPost(captionController.text,
                          "https://open.spotify.com/track/6AOdKVvWB8Ulb3lGCnyPBY?si=56a9bd1fe20743ba");
                      Navigator.of(sheetContext).pop();
                    }
                  },
                  child: const Text('Send'),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ]));
  }
}
