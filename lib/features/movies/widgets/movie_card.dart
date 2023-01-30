import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/movie_model.dart';
import 'card_image.dart';

class MovieCard extends StatelessWidget {
  final Movie? movie;
  final VoidCallback? onTap;
  const MovieCard({
    Key? key,
    this.movie,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 230.h,
          width: 200.w,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(
             5.r,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardImage(
                imageUrl: '${movie?.poster}',
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${movie?.title}',
                softWrap: true,
                overflow: TextOverflow.fade,
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(
                height:2.h,
              ),
              Text(
                '${movie?.plot}',
                textAlign: TextAlign.justify,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${movie?.imdbRating}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
