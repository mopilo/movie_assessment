import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/enum/snack_bar_enum.dart';
import '../../../core/extensions/string_extenstion.dart';
import '../../../core/models/movie_model.dart';
import '../../../core/stores/blocked_store.dart';
import '../../../core/stores/movie_store.dart';

const String _movieSavedStreamKey = 'movie-saved-stream';
const String _movieBlockedStreamkey = 'movie-blocked-stream';

class MovieViewModel extends MultipleStreamViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _movieStore = locator<MovieStore>();
  final _blockedStore = locator<BlockedStore>();

  Movie? _movie;

  MovieViewModel(Movie? movie) {
    _movie = movie;
  }

  bool get savedState => dataMap![_movieSavedStreamKey];
  bool get isSavedStateReady => dataReady(_movieSavedStreamKey);

  bool get blockedState => dataMap![_movieBlockedStreamkey];
  bool get isBlockedStateReady => dataReady(_movieBlockedStreamkey);

  void actionSaveMovie({Movie? movie}) async {
    if (await checkIsSaved(movie: movie) == true) {
      return _snackbarHandler(
        message: 'Movie with title: ${movie?.title} has already been saved',
        title: 'Error',
        variant: SnackBarType.error,
      );
    }
    await _movieStore.addMovie(
      movie: movie,
    );
    _snackbarHandler(
      message: 'Movie with title: ${movie?.title} has been saved',
      title: 'Info',
      variant: SnackBarType.info,
    );
    initialise();
  }

  void actionUnsaveMovie({Movie? movie}) async {
    await _movieStore.removeMovie(
      movie: movie,
    );
    _snackbarHandler(
      message: 'Movie with title: ${movie?.title} has been unsaved',
      title: 'Info',
      variant: SnackBarType.info,
    );
    initialise();
  }

  void actionBlockMovie({Movie? movie}) async {
    if (await checkIsBlocked(movie: movie) == true) {
      return _snackbarHandler(
        message: 'Movie with title: ${movie?.title} has already been blocked',
        title: 'Error',
        variant: SnackBarType.error,
      );
    }
    await _blockedStore.addBlockedTitle(
      movie: movie,
    );
    _snackbarHandler(
      message: 'Movie with title: ${movie?.title} has been blocked',
      title: 'Info',
      variant: SnackBarType.info,
    );
    initialise();
  }

  void actionUnblockMovie({Movie? movie}) async {
    await _blockedStore.removeBlockedTitle(
      movie: movie,
    );
    _snackbarHandler(
      message: 'Movie with title: ${movie?.title} has been unblocked',
      title: 'Info',
      variant: SnackBarType.info,
    );
    initialise();
  }

  Future<bool> checkIsBlocked({Movie? movie}) async {
    bool result =
        await _blockedStore.isBlocked(title: movie?.title?.split(" ").elementAt(0));
    return result;
  }

  Future<bool> checkIsSaved({Movie? movie}) async {
    bool result =
        await _movieStore.isSaved(title: movie?.title?.split(" ").elementAt(0));
    return result;
  }

  void _snackbarHandler({
    dynamic variant,
    required String message,
    required String title,
  }) {
    _snackbarService.showCustomSnackBar(
      message: message,
      variant: variant,
      title: title,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  Map<String, StreamData<bool>> get streamsMap => {
        _movieSavedStreamKey: StreamData<bool>(
          _movieStore.isStreamedSaved(
            title: _movie?.title,
          ),
        ),
        _movieBlockedStreamkey: StreamData<bool>(
          _blockedStore.isStreamBlocked(
            title: _movie?.title,
          ),
        ),
      };
}
