// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  UserModel get author => throw _privateConstructorUsedError;
  set author(UserModel value) => throw _privateConstructorUsedError;
  num get numLikes => throw _privateConstructorUsedError;
  set numLikes(num value) => throw _privateConstructorUsedError;
  String get bodyText => throw _privateConstructorUsedError;
  set bodyText(String value) => throw _privateConstructorUsedError;
  String get musicURL => throw _privateConstructorUsedError;
  set musicURL(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {String id,
      UserModel author,
      num numLikes,
      String bodyText,
      String musicURL});
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = null,
    Object? numLikes = null,
    Object? bodyText = null,
    Object? musicURL = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      numLikes: null == numLikes
          ? _value.numLikes
          : numLikes // ignore: cast_nullable_to_non_nullable
              as num,
      bodyText: null == bodyText
          ? _value.bodyText
          : bodyText // ignore: cast_nullable_to_non_nullable
              as String,
      musicURL: null == musicURL
          ? _value.musicURL
          : musicURL // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostModelCopyWith<$Res> implements $PostModelCopyWith<$Res> {
  factory _$$_PostModelCopyWith(
          _$_PostModel value, $Res Function(_$_PostModel) then) =
      __$$_PostModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      UserModel author,
      num numLikes,
      String bodyText,
      String musicURL});
}

/// @nodoc
class __$$_PostModelCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$_PostModel>
    implements _$$_PostModelCopyWith<$Res> {
  __$$_PostModelCopyWithImpl(
      _$_PostModel _value, $Res Function(_$_PostModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = null,
    Object? numLikes = null,
    Object? bodyText = null,
    Object? musicURL = null,
  }) {
    return _then(_$_PostModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      numLikes: null == numLikes
          ? _value.numLikes
          : numLikes // ignore: cast_nullable_to_non_nullable
              as num,
      bodyText: null == bodyText
          ? _value.bodyText
          : bodyText // ignore: cast_nullable_to_non_nullable
              as String,
      musicURL: null == musicURL
          ? _value.musicURL
          : musicURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostModel with DiagnosticableTreeMixin implements _PostModel {
  _$_PostModel(
      {required this.id,
      required this.author,
      required this.numLikes,
      required this.bodyText,
      required this.musicURL});

  factory _$_PostModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostModelFromJson(json);

  @override
  String id;
  @override
  UserModel author;
  @override
  num numLikes;
  @override
  String bodyText;
  @override
  String musicURL;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostModel(id: $id, author: $author, numLikes: $numLikes, bodyText: $bodyText, musicURL: $musicURL)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('numLikes', numLikes))
      ..add(DiagnosticsProperty('bodyText', bodyText))
      ..add(DiagnosticsProperty('musicURL', musicURL));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      __$$_PostModelCopyWithImpl<_$_PostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostModelToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  factory _PostModel(
      {required String id,
      required UserModel author,
      required num numLikes,
      required String bodyText,
      required String musicURL}) = _$_PostModel;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$_PostModel.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  UserModel get author;
  set author(UserModel value);
  @override
  num get numLikes;
  set numLikes(num value);
  @override
  String get bodyText;
  set bodyText(String value);
  @override
  String get musicURL;
  set musicURL(String value);
  @override
  @JsonKey(ignore: true)
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}
