// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_login_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserLoginEntity {
  String get accessToken;
  UserInfoEntity get user;

  /// Create a copy of UserLoginEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserLoginEntityCopyWith<UserLoginEntity> get copyWith =>
      _$UserLoginEntityCopyWithImpl<UserLoginEntity>(
          this as UserLoginEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserLoginEntity &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken, user);

  @override
  String toString() {
    return 'UserLoginEntity(accessToken: $accessToken, user: $user)';
  }
}

/// @nodoc
abstract mixin class $UserLoginEntityCopyWith<$Res> {
  factory $UserLoginEntityCopyWith(
          UserLoginEntity value, $Res Function(UserLoginEntity) _then) =
      _$UserLoginEntityCopyWithImpl;
  @useResult
  $Res call({String accessToken, UserInfoEntity user});

  $UserInfoEntityCopyWith<$Res> get user;
}

/// @nodoc
class _$UserLoginEntityCopyWithImpl<$Res>
    implements $UserLoginEntityCopyWith<$Res> {
  _$UserLoginEntityCopyWithImpl(this._self, this._then);

  final UserLoginEntity _self;
  final $Res Function(UserLoginEntity) _then;

  /// Create a copy of UserLoginEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? user = null,
  }) {
    return _then(_self.copyWith(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserInfoEntity,
    ));
  }

  /// Create a copy of UserLoginEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoEntityCopyWith<$Res> get user {
    return $UserInfoEntityCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [UserLoginEntity].
extension UserLoginEntityPatterns on UserLoginEntity {
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
    TResult Function(_UserLoginEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserLoginEntity() when $default != null:
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
    TResult Function(_UserLoginEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserLoginEntity():
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
    TResult? Function(_UserLoginEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserLoginEntity() when $default != null:
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
    TResult Function(String accessToken, UserInfoEntity user)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserLoginEntity() when $default != null:
        return $default(_that.accessToken, _that.user);
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
    TResult Function(String accessToken, UserInfoEntity user) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserLoginEntity():
        return $default(_that.accessToken, _that.user);
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
    TResult? Function(String accessToken, UserInfoEntity user)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserLoginEntity() when $default != null:
        return $default(_that.accessToken, _that.user);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UserLoginEntity implements UserLoginEntity {
  const _UserLoginEntity({required this.accessToken, required this.user});

  @override
  final String accessToken;
  @override
  final UserInfoEntity user;

  /// Create a copy of UserLoginEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserLoginEntityCopyWith<_UserLoginEntity> get copyWith =>
      __$UserLoginEntityCopyWithImpl<_UserLoginEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserLoginEntity &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken, user);

  @override
  String toString() {
    return 'UserLoginEntity(accessToken: $accessToken, user: $user)';
  }
}

/// @nodoc
abstract mixin class _$UserLoginEntityCopyWith<$Res>
    implements $UserLoginEntityCopyWith<$Res> {
  factory _$UserLoginEntityCopyWith(
          _UserLoginEntity value, $Res Function(_UserLoginEntity) _then) =
      __$UserLoginEntityCopyWithImpl;
  @override
  @useResult
  $Res call({String accessToken, UserInfoEntity user});

  @override
  $UserInfoEntityCopyWith<$Res> get user;
}

/// @nodoc
class __$UserLoginEntityCopyWithImpl<$Res>
    implements _$UserLoginEntityCopyWith<$Res> {
  __$UserLoginEntityCopyWithImpl(this._self, this._then);

  final _UserLoginEntity _self;
  final $Res Function(_UserLoginEntity) _then;

  /// Create a copy of UserLoginEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? user = null,
  }) {
    return _then(_UserLoginEntity(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserInfoEntity,
    ));
  }

  /// Create a copy of UserLoginEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoEntityCopyWith<$Res> get user {
    return $UserInfoEntityCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
