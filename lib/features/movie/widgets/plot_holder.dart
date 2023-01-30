import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PlotHolder extends StatelessWidget {
  final String? plot;
  const PlotHolder({
    Key? key,
    this.plot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Text(
        '$plot',
        style: theme.textTheme.caption?.copyWith(color: Colors.white),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
