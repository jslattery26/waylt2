import 'package:freezed_annotation/freezed_annotation.dart';
part 'spotify_track.freezed.dart';

@freezed
class SpotifyTrack with _$SpotifyTrack {
  const SpotifyTrack._();

  const factory SpotifyTrack({
    @Default('') String title,
    @Default('') String artist,
    @Default('') String id,
    @Default('') String image,
  }) = _SpotifyTrack;
}
