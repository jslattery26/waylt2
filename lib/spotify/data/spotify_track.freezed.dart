// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spotify_track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpotifyTrack {
  String get title => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpotifyTrackCopyWith<SpotifyTrack> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotifyTrackCopyWith<$Res> {
  factory $SpotifyTrackCopyWith(
          SpotifyTrack value, $Res Function(SpotifyTrack) then) =
      _$SpotifyTrackCopyWithImpl<$Res, SpotifyTrack>;
  @useResult
  $Res call({String title, String artist, String id, String image});
}

/// @nodoc
class _$SpotifyTrackCopyWithImpl<$Res, $Val extends SpotifyTrack>
    implements $SpotifyTrackCopyWith<$Res> {
  _$SpotifyTrackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? artist = null,
    Object? id = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpotifyTrackCopyWith<$Res>
    implements $SpotifyTrackCopyWith<$Res> {
  factory _$$_SpotifyTrackCopyWith(
          _$_SpotifyTrack value, $Res Function(_$_SpotifyTrack) then) =
      __$$_SpotifyTrackCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String artist, String id, String image});
}

/// @nodoc
class __$$_SpotifyTrackCopyWithImpl<$Res>
    extends _$SpotifyTrackCopyWithImpl<$Res, _$_SpotifyTrack>
    implements _$$_SpotifyTrackCopyWith<$Res> {
  __$$_SpotifyTrackCopyWithImpl(
      _$_SpotifyTrack _value, $Res Function(_$_SpotifyTrack) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? artist = null,
    Object? id = null,
    Object? image = null,
  }) {
    return _then(_$_SpotifyTrack(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SpotifyTrack extends _SpotifyTrack {
  const _$_SpotifyTrack(
      {this.title = '', this.artist = '', this.id = '', this.image = ''})
      : super._();

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String artist;
  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String image;

  @override
  String toString() {
    return 'SpotifyTrack(title: $title, artist: $artist, id: $id, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpotifyTrack &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, artist, id, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpotifyTrackCopyWith<_$_SpotifyTrack> get copyWith =>
      __$$_SpotifyTrackCopyWithImpl<_$_SpotifyTrack>(this, _$identity);
}

abstract class _SpotifyTrack extends SpotifyTrack {
  const factory _SpotifyTrack(
      {final String title,
      final String artist,
      final String id,
      final String image}) = _$_SpotifyTrack;
  const _SpotifyTrack._() : super._();

  @override
  String get title;
  @override
  String get artist;
  @override
  String get id;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$_SpotifyTrackCopyWith<_$_SpotifyTrack> get copyWith =>
      throw _privateConstructorUsedError;
}
