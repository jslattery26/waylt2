// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slack_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SlackUserState {
  String get accessToken => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SlackUserStateCopyWith<SlackUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlackUserStateCopyWith<$Res> {
  factory $SlackUserStateCopyWith(
          SlackUserState value, $Res Function(SlackUserState) then) =
      _$SlackUserStateCopyWithImpl<$Res, SlackUserState>;
  @useResult
  $Res call({String accessToken, String name, String image});
}

/// @nodoc
class _$SlackUserStateCopyWithImpl<$Res, $Val extends SlackUserState>
    implements $SlackUserStateCopyWith<$Res> {
  _$SlackUserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? name = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SlackUserStateCopyWith<$Res>
    implements $SlackUserStateCopyWith<$Res> {
  factory _$$_SlackUserStateCopyWith(
          _$_SlackUserState value, $Res Function(_$_SlackUserState) then) =
      __$$_SlackUserStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, String name, String image});
}

/// @nodoc
class __$$_SlackUserStateCopyWithImpl<$Res>
    extends _$SlackUserStateCopyWithImpl<$Res, _$_SlackUserState>
    implements _$$_SlackUserStateCopyWith<$Res> {
  __$$_SlackUserStateCopyWithImpl(
      _$_SlackUserState _value, $Res Function(_$_SlackUserState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? name = null,
    Object? image = null,
  }) {
    return _then(_$_SlackUserState(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SlackUserState extends _SlackUserState {
  const _$_SlackUserState(
      {this.accessToken = '', this.name = '', this.image = ''})
      : super._();

  @override
  @JsonKey()
  final String accessToken;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String image;

  @override
  String toString() {
    return 'SlackUserState(accessToken: $accessToken, name: $name, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SlackUserState &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken, name, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SlackUserStateCopyWith<_$_SlackUserState> get copyWith =>
      __$$_SlackUserStateCopyWithImpl<_$_SlackUserState>(this, _$identity);
}

abstract class _SlackUserState extends SlackUserState {
  const factory _SlackUserState(
      {final String accessToken,
      final String name,
      final String image}) = _$_SlackUserState;
  const _SlackUserState._() : super._();

  @override
  String get accessToken;
  @override
  String get name;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$_SlackUserStateCopyWith<_$_SlackUserState> get copyWith =>
      throw _privateConstructorUsedError;
}