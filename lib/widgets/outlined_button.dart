
import 'package:flutter/material.dart';

class TunedInOutlinedButton extends StatelessWidget {
  final void Function() onPressed;

  final String text;

  final bool toggle;

  const TunedInOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.toggle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => {},
        style: OutlinedButton.styleFrom(
          backgroundColor: toggle ? Theme.of(context).colorScheme.onPrimary : null,
          shape: const StadiumBorder(),
          fixedSize: const Size(100, 36),
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: toggle ? Theme.of(context).colorScheme.primary : null)
        )
    );
  }
}