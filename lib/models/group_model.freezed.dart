// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return _GroupModel.fromJson(json);
}

/// @nodoc
mixin _$GroupModel {
  String? get displayName => throw _privateConstructorUsedError;
  set displayName(String? value) => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  set userName(String? value) => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  set email(String? value) => throw _privateConstructorUsedError;
  String? get admin => throw _privateConstructorUsedError;
  set admin(String? value) =>
      throw _privateConstructorUsedError; // change to UserModel later
  List<String>? get followers =>
      throw _privateConstructorUsedError; // change to UserModel later
  set followers(List<String>? value) =>
      throw _privateConstructorUsedError; // change to UserModel later
  List<String>? get members =>
      throw _privateConstructorUsedError; // change to UserModel later
  set members(List<String>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupModelCopyWith<GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupModelCopyWith<$Res> {
  factory $GroupModelCopyWith(
          GroupModel value, $Res Function(GroupModel) then) =
      _$GroupModelCopyWithImpl<$Res, GroupModel>;
  @useResult
  $Res call(
      {String? displayName,
      String? userName,
      String? email,
      String? admin,
      List<String>? followers,
      List<String>? members});
}

/// @nodoc
class _$GroupModelCopyWithImpl<$Res, $Val extends GroupModel>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? userName = freezed,
    Object? email = freezed,
    Object? admin = freezed,
    Object? followers = freezed,
    Object? members = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      admin: freezed == admin
          ? _value.admin
          : admin // ignore: cast_nullable_to_non_nullable
              as String?,
      followers: freezed == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupModelCopyWith<$Res>
    implements $GroupModelCopyWith<$Res> {
  factory _$$_GroupModelCopyWith(
          _$_GroupModel value, $Res Function(_$_GroupModel) then) =
      __$$_GroupModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? displayName,
      String? userName,
      String? email,
      String? admin,
      List<String>? followers,
      List<String>? members});
}

/// @nodoc
class __$$_GroupModelCopyWithImpl<$Res>
    extends _$GroupModelCopyWithImpl<$Res, _$_GroupModel>
    implements _$$_GroupModelCopyWith<$Res> {
  __$$_GroupModelCopyWithImpl(
      _$_GroupModel _value, $Res Function(_$_GroupModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? userName = freezed,
    Object? email = freezed,
    Object? admin = freezed,
    Object? followers = freezed,
    Object? members = freezed,
  }) {
    return _then(_$_GroupModel(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      admin: freezed == admin
          ? _value.admin
          : admin // ignore: cast_nullable_to_non_nullable
              as String?,
      followers: freezed == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupModel extends _GroupModel with DiagnosticableTreeMixin {
  _$_GroupModel(
      {this.displayName,
      this.userName,
      this.email,
      this.admin,
      this.followers,
      this.members})
      : super._();

  factory _$_GroupModel.fromJson(Map<String, dynamic> json) =>
      _$$_GroupModelFromJson(json);

  @override
  String? displayName;
  @override
  String? userName;
  @override
  String? email;
  @override
  String? admin;
// change to UserModel later
  @override
  List<String>? followers;
// change to UserModel later
  @override
  List<String>? members;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GroupModel(displayName: $displayName, userName: $userName, email: $email, admin: $admin, followers: $followers, members: $members)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GroupModel'))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('userName', userName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('admin', admin))
      ..add(DiagnosticsProperty('followers', followers))
      ..add(DiagnosticsProperty('members', members));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupModelCopyWith<_$_GroupModel> get copyWith =>
      __$$_GroupModelCopyWithImpl<_$_GroupModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupModelToJson(
      this,
    );
  }
}

abstract class _GroupModel extends GroupModel {
  factory _GroupModel(
      {String? displayName,
      String? userName,
      String? email,
      String? admin,
      List<String>? followers,
      List<String>? members}) = _$_GroupModel;
  _GroupModel._() : super._();

  factory _GroupModel.fromJson(Map<String, dynamic> json) =
      _$_GroupModel.fromJson;

  @override
  String? get displayName;
  set displayName(String? value);
  @override
  String? get userName;
  set userName(String? value);
  @override
  String? get email;
  set email(String? value);
  @override
  String? get admin;
  set admin(String? value);
  @override // change to UserModel later
  List<String>? get followers; // change to UserModel later
  set followers(List<String>? value);
  @override // change to UserModel later
  List<String>? get members; // change to UserModel later
  set members(List<String>? value);
  @override
  @JsonKey(ignore: true)
  _$$_GroupModelCopyWith<_$_GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}
