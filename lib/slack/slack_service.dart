import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waylt3/extensions/preferences_extensions.dart';
import 'package:waylt3/global_providers.dart';
import 'package:waylt3/slack/slack_repository.dart';
import 'package:waylt3/slack/slack_user_state.dart';

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

  setName(String name) {
    _preferences.setString('name', name);
    state = state.copyWith(
      name: name,
    );
  }

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
