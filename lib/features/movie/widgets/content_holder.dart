import 'package:flutter/material.dart';


class ContentHolder extends StatelessWidget {
  final String? title;
  final String? content;
  const ContentHolder({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '$title: ',
          style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        Text(
          '$content',
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.subtitle2?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
