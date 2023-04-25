import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waylt3/global_providers.dart';
import 'package:logger/logger.dart';
import 'package:waylt3/spotify/spotify_view_model.dart';

final spotifyServiceProvider = Provider<SpotifyService>((ref) {
  return SpotifyService(ref);
});

class SpotifyService {
  SpotifyService(this.ref) {
    _init();
  }

  final Ref ref;
  Logger get logger => ref.read(loggerProvider);

  Future<void> _init() async {
    logger.wtf('spotify service has been initialized');
    ref.listen<AsyncValue<dynamic>>(
      spotifySyncStreamProvider,
      (previous, next) {},
    );
  }
}
