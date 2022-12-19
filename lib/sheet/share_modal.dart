import 'package:flutter/material.dart';
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
                    getTargetName: (index) => 'Will Rice College',
                    getTargetIcon: (index) => const Icon(Icons.school),
                    buildTargetPage: (index) =>
                        const Text("This is the end of the line"),
                  );
                },
              );
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
