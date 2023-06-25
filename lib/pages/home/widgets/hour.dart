import 'package:flutter/material.dart';

class Hour extends StatelessWidget {
  final int hour;
  final double hourHeight;

  const Hour({
    Key? key,
    required this.hour,
    required this.hourHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: hourHeight,
        child: RichText(
          text: TextSpan(
              text: '$hour',
              children: [
                TextSpan(
                  text: ' 00',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}
