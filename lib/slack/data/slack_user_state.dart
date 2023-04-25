import 'package:freezed_annotation/freezed_annotation.dart';
part 'slack_user_state.freezed.dart';

@freezed
class SlackUserState with _$SlackUserState {
  const SlackUserState._();

  const factory SlackUserState({
    @Default('') String accessToken,
    @Default('') String name,
    @Default('') String image,
  }) = _SlackUserState;
}
