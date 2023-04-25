import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waylt3/global_providers.dart';
import 'package:waylt3/spotify/applescript.dart';
import 'package:waylt3/spotify/data/spotify_track.dart';

final spotifyRepositoryProvider = Provider<SpotifyRepository>((ref) {
  return SpotifyRepository(ref);
});

class SpotifyRepository {
  final Ref ref;

  SpotifyRepository(this.ref);

  getTrackID() async {
    const script = AppleScript(
      'tell application "Spotify" to id of current track as string',
    );
    return (await script.run()).stdout;
  }

  getImage() async {
    const script = AppleScript(
      'tell application "Spotify" to artwork url of current track as string',
    );
    return (await script.run()).stdout;
  }

  getArtistName() async {
    const script = AppleScript(
      'tell application "Spotify" to artist of current track as string',
    );
    return (await script.run()).stdout;
  }

  getTrackName() async {
    const script = AppleScript(
      'tell application "Spotify" to name of current track as string',
    );
    return (await script.run()).stdout;
  }

  Future<SpotifyTrack?> getCurrentlyPlaying() async {
    try {
      final title = await getTrackName();
      final artist = await getArtistName();
      final trackID = await getTrackID();
      final image = await getImage();

      return SpotifyTrack(
        title: title.trim(),
        artist: artist.trim(),
        id: trackID.trim(),
        image: image.trim(),
      );
    } catch (err) {
      ref.read(loggerProvider).e(err);
      return null;
    }
  }
  // getFormattedTrack(): string {
  //   if (!this.lastTrack) {
  //     throw Error('Could not fetch track');
  //   }

  //   const { titleLarge, artist } = this.lastTrack;
  //   return `${titleLarge} - ${artist}`;
  // }

  // isNewTrackPlaying({ id, title, artist }: SpotifyTrack): boolean {
  //   if (!this.lastTrack) {
  //     return true;
  //   }

  //   return (
  //     id !== this.lastTrack.id || title !== this.lastTrack.title || artist !== this.lastTrack.artist
  //   );
  // }

  // setLastTrack(track = SpotifyTrack) {
  //   this.lastTrack = track;
  // }

  // getLastTrack() {
  //   return this.lastTrack;
  // }
}
