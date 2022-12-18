import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class TunedInBottomSheet extends StatelessWidget {
  final Widget Function(BuildContext context, BuildContext modalContext, void Function(BuildContext context, BuildContext modalContext, String title, Widget child)) builder;
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

  void pushRoute(BuildContext context, BuildContext modalContext, String title, Widget child) {
    Navigator.of(modalContext).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: Scaffold(
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
          body: child,
        ),
      ),
    );
  }
}