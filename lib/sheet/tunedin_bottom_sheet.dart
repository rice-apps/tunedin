import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// TO:DO
// Use provider maybe for this to propagate down tree
typedef PushRouteBuilder = void Function({
      required Widget child,
      required BuildContext pageContext,
      required BuildContext sheetContext,
      required String title
    });

typedef TunedInBottomSheetBuilder = Widget Function(
    BuildContext sheetContext, BuildContext pageContext, PushRouteBuilder pushRoute);

class TunedInBottomSheet extends StatelessWidget {
  final TunedInBottomSheetBuilder builder;
  final String title;

  const TunedInBottomSheet({super.key, required this.builder, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute<void>(
          builder: (BuildContext contentContext) => Scaffold(
            appBar: AppBar(
              title: Text(title),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            body: builder(context, contentContext, pushRoute)
          )
        ),
      ),
    );
  }

  void pushRoute({required BuildContext sheetContext, required BuildContext pageContext, required String title, required Widget child}) {
    Navigator.of(pageContext).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
          body: child,
        ),
      ),
    );
  }
}