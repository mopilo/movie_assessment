import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/movie_model.dart';
import '../../core/shared_widgets/app_cache_network_image.dart';
import '../../core/shared_widgets/image_error_widget.dart';
import 'view_model/movie_viewmodel.dart';
import 'widgets/action_button.dart';
import 'widgets/content_holder.dart';
import 'widgets/plot_holder.dart';

class MovieView extends StatelessWidget {
  final Movie? movie;
  const MovieView({
    Key? key,
    this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<MovieViewModel>.reactive(
      viewModelBuilder: () => MovieViewModel(movie),
      builder: (
        BuildContext context,
        MovieViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              '${movie?.title}',
              style: theme.textTheme.titleLarge,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.orangeAccent,
            elevation: 0,
          ),
          body: Column(
            children: [
              Stack(
                children: [
                  Builder(
                    builder: (context) {
                      if (movie?.poster == 'N/A') {
                        return ImageErrorWidget(
                          height: 300.h,
                        );
                      }
                      return AppCacheNetworkImage(
                        imageUrl: '${movie?.poster}',
                        height: 400.h,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 400.h,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${movie?.poster}'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              Container(
                width: 1.sw,
                height: 70.h,
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie!.released!,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white, fontSize: 11.sp),
                    ),
                    const CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.orangeAccent,
                    ),
                    Text(
                      movie!.type!,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white, fontSize: 11.sp),
                    ),
                    const CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.orangeAccent,
                    ),
                   
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${movie?.imdbRating}',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white, fontSize: 11.sp),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.orangeAccent,
                          size: 15,
                        )
                      ],
                    ),
                  ],
                ),
              ),
               Text(
                 movie!.language!,
                 textAlign: TextAlign.center,
                 style: theme.textTheme.bodyMedium
                     ?.copyWith(color: Colors.white, fontSize: 11.sp),
               ),
              PlotHolder(
                plot: movie?.plot,
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 30.h),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Builder(
                      builder: (context) {
                        if (!model.isSavedStateReady) {
                          return const CircularProgressIndicator.adaptive();
                        }
                        if (model.savedState == true) {
                          return ActionButton(
                            title: 'Unfavorite',
                            icon: Icons.favorite,
                            onTap: () {
                              model.actionUnsaveMovie(movie: movie);
                            },
                          );
                        }
                        return ActionButton(
                          title: 'Favorite',
                          icon: Icons.favorite_outline,
                          onTap: () {
                            model.actionSaveMovie(movie: movie);
                          },
                        );
                      },
                    ),
                    Builder(
                      builder: (context) {
                        if (!model.isBlockedStateReady) {
                          return const CircularProgressIndicator.adaptive();
                        }
                        if (model.blockedState == true) {
                          return ActionButton(
                            title: 'Unblock',
                            icon: Icons.circle_outlined,
                            onTap: () {
                              model.actionUnblockMovie(movie: movie);
                            },
                          );
                        }
              
                        return ActionButton(
                          title: 'Block',
                          icon: Icons.block,
                          onTap: () {
                            model.actionBlockMovie(movie: movie);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
