// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spotify_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpotifyState {
  SpotifyTrack? get currentSong => throw _privateConstructorUsedError;
  SpotifyTrack? get lastSongOnDevice => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpotifyStateCopyWith<SpotifyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotifyStateCopyWith<$Res> {
  factory $SpotifyStateCopyWith(
          SpotifyState value, $Res Function(SpotifyState) then) =
      _$SpotifyStateCopyWithImpl<$Res, SpotifyState>;
  @useResult
  $Res call({SpotifyTrack? currentSong, SpotifyTrack? lastSongOnDevice});

  $SpotifyTrackCopyWith<$Res>? get currentSong;
  $SpotifyTrackCopyWith<$Res>? get lastSongOnDevice;
}

/// @nodoc
class _$SpotifyStateCopyWithImpl<$Res, $Val extends SpotifyState>
    implements $SpotifyStateCopyWith<$Res> {
  _$SpotifyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSong = freezed,
    Object? lastSongOnDevice = freezed,
  }) {
    return _then(_value.copyWith(
      currentSong: freezed == currentSong
          ? _value.currentSong
          : currentSong // ignore: cast_nullable_to_non_nullable
              as SpotifyTrack?,
      lastSongOnDevice: freezed == lastSongOnDevice
          ? _value.lastSongOnDevice
          : lastSongOnDevice // ignore: cast_nullable_to_non_nullable
              as SpotifyTrack?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpotifyTrackCopyWith<$Res>? get currentSong {
    if (_value.currentSong == null) {
      return null;
    }

    return $SpotifyTrackCopyWith<$Res>(_value.currentSong!, (value) {
      return _then(_value.copyWith(currentSong: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SpotifyTrackCopyWith<$Res>? get lastSongOnDevice {
    if (_value.lastSongOnDevice == null) {
      return null;
    }

    return $SpotifyTrackCopyWith<$Res>(_value.lastSongOnDevice!, (value) {
      return _then(_value.copyWith(lastSongOnDevice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SpotifyStateCopyWith<$Res>
    implements $SpotifyStateCopyWith<$Res> {
  factory _$$_SpotifyStateCopyWith(
          _$_SpotifyState value, $Res Function(_$_SpotifyState) then) =
      __$$_SpotifyStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SpotifyTrack? currentSong, SpotifyTrack? lastSongOnDevice});

  @override
  $SpotifyTrackCopyWith<$Res>? get currentSong;
  @override
  $SpotifyTrackCopyWith<$Res>? get lastSongOnDevice;
}

/// @nodoc
class __$$_SpotifyStateCopyWithImpl<$Res>
    extends _$SpotifyStateCopyWithImpl<$Res, _$_SpotifyState>
    implements _$$_SpotifyStateCopyWith<$Res> {
  __$$_SpotifyStateCopyWithImpl(
      _$_SpotifyState _value, $Res Function(_$_SpotifyState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSong = freezed,
    Object? lastSongOnDevice = freezed,
  }) {
    return _then(_$_SpotifyState(
      currentSong: freezed == currentSong
          ? _value.currentSong
          : currentSong // ignore: cast_nullable_to_non_nullable
              as SpotifyTrack?,
      lastSongOnDevice: freezed == lastSongOnDevice
          ? _value.lastSongOnDevice
          : lastSongOnDevice // ignore: cast_nullable_to_non_nullable
              as SpotifyTrack?,
    ));
  }
}

/// @nodoc

class _$_SpotifyState extends _SpotifyState {
  const _$_SpotifyState({this.currentSong, this.lastSongOnDevice}) : super._();

  @override
  final SpotifyTrack? currentSong;
  @override
  final SpotifyTrack? lastSongOnDevice;

  @override
  String toString() {
    return 'SpotifyState(currentSong: $currentSong, lastSongOnDevice: $lastSongOnDevice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpotifyState &&
            (identical(other.currentSong, currentSong) ||
                other.currentSong == currentSong) &&
            (identical(other.lastSongOnDevice, lastSongOnDevice) ||
                other.lastSongOnDevice == lastSongOnDevice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentSong, lastSongOnDevice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpotifyStateCopyWith<_$_SpotifyState> get copyWith =>
      __$$_SpotifyStateCopyWithImpl<_$_SpotifyState>(this, _$identity);
}

abstract class _SpotifyState extends SpotifyState {
  const factory _SpotifyState(
      {final SpotifyTrack? currentSong,
      final SpotifyTrack? lastSongOnDevice}) = _$_SpotifyState;
  const _SpotifyState._() : super._();

  @override
  SpotifyTrack? get currentSong;
  @override
  SpotifyTrack? get lastSongOnDevice;
  @override
  @JsonKey(ignore: true)
  _$$_SpotifyStateCopyWith<_$_SpotifyState> get copyWith =>
      throw _privateConstructorUsedError;
}
