import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rice_music_sharing/sheet/tunedin_bottom_sheet.dart';

class ShareModal extends StatefulWidget {
  const ShareModal({super.key});

  @override
  _ShareModalState createState() => _ShareModalState();
}

class _ShareModalState extends State<ShareModal> {
  @override
  Widget build(BuildContext context) {
    return TunedInBottomSheet(
        builder: (sheetContext, pageContext, pushRoute) {
          return TargetPickerPage(
            sheetContext,
            pageContext,
            pushRoute,
            getTargetIcon: (target) =>
                Icon(0 == target ? Icons.person : Icons.group),
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
                      buildTargetPage: (index) => ShareCommentPage(),
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
                    return ShareCommentPage();
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
                return ListTile(
                  title: Text(widget.getTargetName(index)),
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
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: MaterialButton(
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
  const ShareCommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "https://picsum.photos/250?image=9",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              const Text("Playlist"),
              SizedBox(height: 2),
              const Text("Name"),
            ]),
          ),
          SizedBox(height: 4),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 12,
                maxLength: 1000,
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            onPressed: () {
              // implement networking here
              Navigator.of(context).pop();
            },
            child: const Text('Submit'),
          ),
        ),
      ),
    ]);
  }
}
