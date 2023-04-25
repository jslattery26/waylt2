import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:waylt3/spotify/data/spotify_track.dart';
part 'spotify_state.freezed.dart';

@freezed
class SpotifyState with _$SpotifyState {
  const SpotifyState._();

  const factory SpotifyState({
    SpotifyTrack? currentSong,
    SpotifyTrack? lastSongOnDevice,
  }) = _SpotifyState;
}
