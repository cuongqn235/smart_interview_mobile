// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInfoEntity {
  int get id;
  String get email;
  String get name;
  String get avatar;
  String get platform;
  String get subscription;
  DateTime get createdAt;

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserInfoEntityCopyWith<UserInfoEntity> get copyWith =>
      _$UserInfoEntityCopyWithImpl<UserInfoEntity>(
          this as UserInfoEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserInfoEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, name, avatar, platform, subscription, createdAt);

  @override
  String toString() {
    return 'UserInfoEntity(id: $id, email: $email, name: $name, avatar: $avatar, platform: $platform, subscription: $subscription, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $UserInfoEntityCopyWith<$Res> {
  factory $UserInfoEntityCopyWith(
          UserInfoEntity value, $Res Function(UserInfoEntity) _then) =
      _$UserInfoEntityCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String email,
      String name,
      String avatar,
      String platform,
      String subscription,
      DateTime createdAt});
}

/// @nodoc
class _$UserInfoEntityCopyWithImpl<$Res>
    implements $UserInfoEntityCopyWith<$Res> {
  _$UserInfoEntityCopyWithImpl(this._self, this._then);

  final UserInfoEntity _self;
  final $Res Function(UserInfoEntity) _then;

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatar = null,
    Object? platform = null,
    Object? subscription = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      subscription: null == subscription
          ? _self.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserInfoEntity].
extension UserInfoEntityPatterns on UserInfoEntity {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserInfoEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserInfoEntity() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserInfoEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserInfoEntity():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserInfoEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserInfoEntity() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String email, String name, String avatar,
            String platform, String subscription, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserInfoEntity() when $default != null:
        return $default(_that.id, _that.email, _that.name, _that.avatar,
            _that.platform, _that.subscription, _that.createdAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String email, String name, String avatar,
            String platform, String subscription, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserInfoEntity():
        return $default(_that.id, _that.email, _that.name, _that.avatar,
            _that.platform, _that.subscription, _that.createdAt);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String email, String name, String avatar,
            String platform, String subscription, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserInfoEntity() when $default != null:
        return $default(_that.id, _that.email, _that.name, _that.avatar,
            _that.platform, _that.subscription, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UserInfoEntity implements UserInfoEntity {
  const _UserInfoEntity(
      {required this.id,
      required this.email,
      required this.name,
      required this.avatar,
      required this.platform,
      required this.subscription,
      required this.createdAt});

  @override
  final int id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String avatar;
  @override
  final String platform;
  @override
  final String subscription;
  @override
  final DateTime createdAt;

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserInfoEntityCopyWith<_UserInfoEntity> get copyWith =>
      __$UserInfoEntityCopyWithImpl<_UserInfoEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserInfoEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, name, avatar, platform, subscription, createdAt);

  @override
  String toString() {
    return 'UserInfoEntity(id: $id, email: $email, name: $name, avatar: $avatar, platform: $platform, subscription: $subscription, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$UserInfoEntityCopyWith<$Res>
    implements $UserInfoEntityCopyWith<$Res> {
  factory _$UserInfoEntityCopyWith(
          _UserInfoEntity value, $Res Function(_UserInfoEntity) _then) =
      __$UserInfoEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String name,
      String avatar,
      String platform,
      String subscription,
      DateTime createdAt});
}

/// @nodoc
class __$UserInfoEntityCopyWithImpl<$Res>
    implements _$UserInfoEntityCopyWith<$Res> {
  __$UserInfoEntityCopyWithImpl(this._self, this._then);

  final _UserInfoEntity _self;
  final $Res Function(_UserInfoEntity) _then;

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatar = null,
    Object? platform = null,
    Object? subscription = null,
    Object? createdAt = null,
  }) {
    return _then(_UserInfoEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      subscription: null == subscription
          ? _self.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
