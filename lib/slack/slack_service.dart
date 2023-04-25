import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waylt3/extensions/preferences_extensions.dart';
import 'package:waylt3/global_providers.dart';
import 'package:waylt3/slack/data/slack_user_state.dart';
import 'package:waylt3/slack/slack_repository.dart';

final slackUserModelProvider =
    StateNotifierProvider<SlackUserModel, SlackUserState>(
  (ref) => SlackUserModel(
    ref: ref,
    preferences: ref.watch(userPreferencesProvider(null)),
  ),
  name: 'DisplayPreferencesProvider',
);

class SlackUserModel extends StateNotifier<SlackUserState> {
  SlackUserModel({
    required this.ref,
    required Preferences preferences,
  })  : _preferences = preferences,
        super(
          SlackUserState(
            accessToken: preferences.getString('accessToken', ''),
            name: preferences.getString('name', ''),
            image: preferences.getString('image', ''),
          ),
        );

  final Ref ref;
  final Preferences _preferences;

  setAccessToken(String accessToken) async {
    state = state.copyWith(
      accessToken: accessToken,
    );
    final repo = ref.read(slackRepositoryProvider);
    final userData = await repo.fetchUserData(accessToken);
    state = state.copyWith(
      accessToken: accessToken,
      name: userData!.item1,
      image: userData.item2,
    );
    _preferences.setString('accessToken', accessToken);
    _preferences.setString(
      'name',
      userData.item1,
    );
    _preferences.setString(
      'image',
      userData.item2,
    );
  }

  postStatus(String message) async {
    final repo = ref.read(slackRepositoryProvider);
    repo.postStatus(message, state.accessToken);
  }

  setName(String name) {
    _preferences.setString('name', name);
    state = state.copyWith(
      name: name,
    );
  }

  setCurrentTrack() {}

  resetAll() {
    state = state.copyWith(
      accessToken: '',
      name: '',
      image: '',
    );
    _preferences.setString('accessToken', '');
    _preferences.setString('name', '');
    _preferences.setString('image', '');
  }
}
