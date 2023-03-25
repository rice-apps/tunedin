// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlaylistModel _$PlaylistModelFromJson(Map<String, dynamic> json) {
  return _PlaylistModel.fromJson(json);
}

/// @nodoc
mixin _$PlaylistModel {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  List<SongModel> get songs => throw _privateConstructorUsedError;
  set songs(List<SongModel> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaylistModelCopyWith<PlaylistModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistModelCopyWith<$Res> {
  factory $PlaylistModelCopyWith(
          PlaylistModel value, $Res Function(PlaylistModel) then) =
      _$PlaylistModelCopyWithImpl<$Res, PlaylistModel>;
  @useResult
  $Res call({String id, String name, List<SongModel> songs});
}

/// @nodoc
class _$PlaylistModelCopyWithImpl<$Res, $Val extends PlaylistModel>
    implements $PlaylistModelCopyWith<$Res> {
  _$PlaylistModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? songs = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<SongModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlaylistModelCopyWith<$Res>
    implements $PlaylistModelCopyWith<$Res> {
  factory _$$_PlaylistModelCopyWith(
          _$_PlaylistModel value, $Res Function(_$_PlaylistModel) then) =
      __$$_PlaylistModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, List<SongModel> songs});
}

/// @nodoc
class __$$_PlaylistModelCopyWithImpl<$Res>
    extends _$PlaylistModelCopyWithImpl<$Res, _$_PlaylistModel>
    implements _$$_PlaylistModelCopyWith<$Res> {
  __$$_PlaylistModelCopyWithImpl(
      _$_PlaylistModel _value, $Res Function(_$_PlaylistModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? songs = null,
  }) {
    return _then(_$_PlaylistModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<SongModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlaylistModel implements _PlaylistModel {
  _$_PlaylistModel({required this.id, required this.name, required this.songs});

  factory _$_PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$$_PlaylistModelFromJson(json);

  @override
  String id;
  @override
  String name;
  @override
  List<SongModel> songs;

  @override
  String toString() {
    return 'PlaylistModel(id: $id, name: $name, songs: $songs)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlaylistModelCopyWith<_$_PlaylistModel> get copyWith =>
      __$$_PlaylistModelCopyWithImpl<_$_PlaylistModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaylistModelToJson(
      this,
    );
  }
}

abstract class _PlaylistModel implements PlaylistModel {
  factory _PlaylistModel(
      {required String id,
      required String name,
      required List<SongModel> songs}) = _$_PlaylistModel;

  factory _PlaylistModel.fromJson(Map<String, dynamic> json) =
      _$_PlaylistModel.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String get name;
  set name(String value);
  @override
  List<SongModel> get songs;
  set songs(List<SongModel> value);
  @override
  @JsonKey(ignore: true)
  _$$_PlaylistModelCopyWith<_$_PlaylistModel> get copyWith =>
      throw _privateConstructorUsedError;
}
