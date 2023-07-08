import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  const TitleCard(
      {super.key,
      required this.title,
      required this.value,
      this.titleStyle,
      this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: title,
      style: titleStyle ??
          Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
      children: [
        TextSpan(
          text: value,
          style: valueStyle ??
              Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.normal, fontSize: 20),
        )
      ],
    ));
  }
}
