import 'package:flutter/material.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {},
          child: const InfoCard(
            hasChevron: true,
          )),
    );
  }
}

class InfoCard extends StatelessWidget {
  final bool hasChevron;

  const InfoCard({
    Key? key,
    this.hasChevron = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://picsum.photos/250?image=9",
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Playlist Name",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text("20 Songs",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: const Color(0xFFA1A9BC),
                    )),
          ],
        ),
        if (hasChevron) const Spacer(),
        if (hasChevron)
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Icon(Icons.chevron_right),
          ),
      ],
    );
  }
}

// For padding of the words before playist cards
class Label extends StatelessWidget {
  final String name;
  final String count;

  const Label({Key? key, required this.name, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
      child: RichText(
          text: TextSpan(
        text: '$name ',
        style: Theme.of(context).textTheme.headlineMedium,
        children: [
          const WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: SizedBox(width: 5)),
          TextSpan(
            text: count,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFFA1A9BC),
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      )),
    );
  }
}
