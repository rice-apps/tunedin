import 'package:flutter/material.dart';
import 'package:rice_music_sharing/sheet/tunedin_bottom_sheet.dart';

class ShareModal extends StatefulWidget {
  const ShareModal({super.key});

  @override
  ShareModalState createState() => ShareModalState();
}

class ShareModalState extends State<ShareModal> {
  @override
  Widget build(BuildContext context) {
    return TunedInBottomSheet(
        builder: (sheetContext, pageContext, pushRoute) {
          return TargetPickerPage(
            sheetContext,
            pageContext,
            pushRoute,
            getTargetIcon: (target) => DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color(0xFF45495C),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(0 == target ? Icons.person : Icons.group),
                )),
            getTargetName: (target) => 0 == target ? 'Your profile' : 'Group',
            maxCount: 2,
            buildTargetPage: (int index) {
              if (index == 1) {
                return TargetPickerPage(
                  sheetContext,
                  pageContext,
                  pushRoute,
                  getTargetName: (index) => 'Will Rice College',
                  getTargetIcon: (index) => const Icon(Icons.school),
                  buildTargetPage: (int index) {
                    return TargetPickerPage(
                      sheetContext,
                      pageContext,
                      pushRoute,
                      getTargetName: (index) => 'Playlist',
                      getTargetIcon: (index) => const Icon(Icons.playlist_play),
                      buildTargetPage: (index) =>
                          ShareCommentPage(sheetContext),
                    );
                  },
                );
              } else {
                return TargetPickerPage(
                  sheetContext,
                  pageContext,
                  pushRoute,
                  getTargetName: (index) => 'Playlist',
                  getTargetIcon: (index) => const Icon(Icons.playlist_play),
                  buildTargetPage: (int index) {
                    return ShareCommentPage(sheetContext);
                  },
                );
              }
            },
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

  const TargetPickerPage(
    this.sheetContext,
    this.pageContext,
    this.pushRoute, {
    Key? key,
    required this.getTargetName,
    required this.getTargetIcon,
    this.maxCount,
    required this.buildTargetPage,
  }) : super(key: key);

  @override
  State<TargetPickerPage> createState() => _TargetPickerPageState();
}

class _TargetPickerPageState extends State<TargetPickerPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ListView.builder(
              itemCount: widget.maxCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: ListTile(
                    title: Text(
                      widget.getTargetName(index),
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                    leading: widget.getTargetIcon(index),
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
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
            ),
          ),
        ],
      ),
    );
  }
}

class ShareCommentPage extends StatelessWidget {
  final BuildContext sheetContext;
  const ShareCommentPage(this.sheetContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://picsum.photos/250?image=9",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text("Playlist",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
            const SizedBox(height: 2),
            Text("Name",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                style: Theme.of(context).textTheme.displaySmall,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                maxLength: 1000,
                decoration: InputDecoration(
                    counterStyle: Theme.of(context).textTheme.displaySmall,
                    hintText: 'Share your thoughts...',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Color(0xFF969BB5))),
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
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
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: ElevatedButton(
            onPressed: () {
              // implement networking here
              Navigator.of(sheetContext).pop();
            },
            child: const Text('Submit'),
          ),
        ),
      ),
    ]);
  }
}
