import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/movie_model.dart';
import 'view_model/movies_viewmodel.dart';
import 'widgets/movie_card.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<MoviesViewModel>.reactive(
      viewModelBuilder: () => MoviesViewModel(),
      builder: (
        BuildContext context,
        MoviesViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: Column(
            children: [
              Text(
                'My Movies',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 30.sp,
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (model.data?.isEmpty == true || model.data == null) {
                      return Center(
                        child: Text(
                          'No Favorite movie(s) Saved.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                        top: 15.h,
                        left:5.w,
                        right: 5.w,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 5.w,
                        mainAxisExtent: 230.h,
                      ),
                      itemCount: model.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Movie? movie = model.data?.elementAt(index);
                        return MovieCard(
                          movie: movie,
                          onTap: () {
                            model.actionRouteToMovie(movie: movie);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
