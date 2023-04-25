import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waylt3/extensions/preferences_extensions.dart';
import 'package:waylt3/global_providers.dart';
import 'package:waylt3/slack/slack_service.dart';
import 'package:waylt3/spotify/data/spotify_state.dart';
import 'package:waylt3/spotify/domain/spotify_repository.dart';

final spotifyViewModelProvider =
    StateNotifierProvider<SpotifyViewModel, SpotifyState>(
  (ref) => SpotifyViewModel(
    ref: ref,
    preferences: ref.watch(userPreferencesProvider(null)),
    repository: ref.watch(spotifyRepositoryProvider),
  ),
  name: 'DisplayPreferencesProvider',
);

final spotifySyncStreamProvider = StreamProvider<void>((ref) {
  final vm = ref.watch(spotifyViewModelProvider.notifier);
  return vm.syncStream();
});

class SpotifyViewModel extends StateNotifier<SpotifyState> {
  SpotifyViewModel({
    required this.ref,
    required Preferences preferences,
    required SpotifyRepository repository,
  })  : _preferences = preferences,
        srepository = repository,
        super(
          const SpotifyState(),
        );

  final Ref ref;
  final Preferences _preferences;
  final SpotifyRepository srepository;

  Stream<dynamic> syncStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      final song = await srepository.getCurrentlyPlaying();
      if (song != state.currentSong) {
        state = state.copyWith(currentSong: song);
        final slackVm = ref.read(slackUserModelProvider.notifier);
        slackVm.postStatus(
          '${song!.title} - ${song.artist}',
        );
      }
    }
  }
}
