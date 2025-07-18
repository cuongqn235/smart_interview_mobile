// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent()';
  }
}

/// @nodoc
class $AuthEventCopyWith<$Res> {
  $AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}

/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppLoadedEvent value)? appLoaded,
    TResult Function(_LoginEvent value)? login,
    TResult Function(_SetFirstLaunchEvent value)? setFirstLaunch,
    TResult Function(_StartedEvent value)? started,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppLoadedEvent() when appLoaded != null:
        return appLoaded(_that);
      case _LoginEvent() when login != null:
        return login(_that);
      case _SetFirstLaunchEvent() when setFirstLaunch != null:
        return setFirstLaunch(_that);
      case _StartedEvent() when started != null:
        return started(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_AppLoadedEvent value) appLoaded,
    required TResult Function(_LoginEvent value) login,
    required TResult Function(_SetFirstLaunchEvent value) setFirstLaunch,
    required TResult Function(_StartedEvent value) started,
  }) {
    final _that = this;
    switch (_that) {
      case _AppLoadedEvent():
        return appLoaded(_that);
      case _LoginEvent():
        return login(_that);
      case _SetFirstLaunchEvent():
        return setFirstLaunch(_that);
      case _StartedEvent():
        return started(_that);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppLoadedEvent value)? appLoaded,
    TResult? Function(_LoginEvent value)? login,
    TResult? Function(_SetFirstLaunchEvent value)? setFirstLaunch,
    TResult? Function(_StartedEvent value)? started,
  }) {
    final _that = this;
    switch (_that) {
      case _AppLoadedEvent() when appLoaded != null:
        return appLoaded(_that);
      case _LoginEvent() when login != null:
        return login(_that);
      case _SetFirstLaunchEvent() when setFirstLaunch != null:
        return setFirstLaunch(_that);
      case _StartedEvent() when started != null:
        return started(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appLoaded,
    TResult Function()? login,
    TResult Function()? setFirstLaunch,
    TResult Function()? started,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppLoadedEvent() when appLoaded != null:
        return appLoaded();
      case _LoginEvent() when login != null:
        return login();
      case _SetFirstLaunchEvent() when setFirstLaunch != null:
        return setFirstLaunch();
      case _StartedEvent() when started != null:
        return started();
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
  TResult when<TResult extends Object?>({
    required TResult Function() appLoaded,
    required TResult Function() login,
    required TResult Function() setFirstLaunch,
    required TResult Function() started,
  }) {
    final _that = this;
    switch (_that) {
      case _AppLoadedEvent():
        return appLoaded();
      case _LoginEvent():
        return login();
      case _SetFirstLaunchEvent():
        return setFirstLaunch();
      case _StartedEvent():
        return started();
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appLoaded,
    TResult? Function()? login,
    TResult? Function()? setFirstLaunch,
    TResult? Function()? started,
  }) {
    final _that = this;
    switch (_that) {
      case _AppLoadedEvent() when appLoaded != null:
        return appLoaded();
      case _LoginEvent() when login != null:
        return login();
      case _SetFirstLaunchEvent() when setFirstLaunch != null:
        return setFirstLaunch();
      case _StartedEvent() when started != null:
        return started();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AppLoadedEvent implements AuthEvent {
  const _AppLoadedEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _AppLoadedEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.appLoaded()';
  }
}

/// @nodoc

class _LoginEvent implements AuthEvent {
  const _LoginEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoginEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.login()';
  }
}

/// @nodoc

class _SetFirstLaunchEvent implements AuthEvent {
  const _SetFirstLaunchEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SetFirstLaunchEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.setFirstLaunch()';
  }
}

/// @nodoc

class _StartedEvent implements AuthEvent {
  const _StartedEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _StartedEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.started()';
  }
}

/// @nodoc
mixin _$AuthState {
  bool get isLoaded;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateCopyWith<AuthState> get copyWith =>
      _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthState &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoaded);

  @override
  String toString() {
    return 'AuthState(isLoaded: $isLoaded)';
  }
}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) =
      _$AuthStateCopyWithImpl;
  @useResult
  $Res call({bool isLoaded});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoaded = null,
  }) {
    return _then(_self.copyWith(
      isLoaded: null == isLoaded
          ? _self.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticatedState value)? authenticated,
    TResult Function(_InitialState value)? initial,
    TResult Function(_LoginState value)? login,
    TResult Function(_OnboardingState value)? onboarding,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticatedState() when authenticated != null:
        return authenticated(_that);
      case _InitialState() when initial != null:
        return initial(_that);
      case _LoginState() when login != null:
        return login(_that);
      case _OnboardingState() when onboarding != null:
        return onboarding(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticatedState value) authenticated,
    required TResult Function(_InitialState value) initial,
    required TResult Function(_LoginState value) login,
    required TResult Function(_OnboardingState value) onboarding,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticatedState():
        return authenticated(_that);
      case _InitialState():
        return initial(_that);
      case _LoginState():
        return login(_that);
      case _OnboardingState():
        return onboarding(_that);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticatedState value)? authenticated,
    TResult? Function(_InitialState value)? initial,
    TResult? Function(_LoginState value)? login,
    TResult? Function(_OnboardingState value)? onboarding,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticatedState() when authenticated != null:
        return authenticated(_that);
      case _InitialState() when initial != null:
        return initial(_that);
      case _LoginState() when login != null:
        return login(_that);
      case _OnboardingState() when onboarding != null:
        return onboarding(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserInfoEntity user, bool isLoaded)? authenticated,
    TResult Function(bool isLoaded)? initial,
    TResult Function(bool isLoaded)? login,
    TResult Function(bool isLoaded)? onboarding,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticatedState() when authenticated != null:
        return authenticated(_that.user, _that.isLoaded);
      case _InitialState() when initial != null:
        return initial(_that.isLoaded);
      case _LoginState() when login != null:
        return login(_that.isLoaded);
      case _OnboardingState() when onboarding != null:
        return onboarding(_that.isLoaded);
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
  TResult when<TResult extends Object?>({
    required TResult Function(UserInfoEntity user, bool isLoaded) authenticated,
    required TResult Function(bool isLoaded) initial,
    required TResult Function(bool isLoaded) login,
    required TResult Function(bool isLoaded) onboarding,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticatedState():
        return authenticated(_that.user, _that.isLoaded);
      case _InitialState():
        return initial(_that.isLoaded);
      case _LoginState():
        return login(_that.isLoaded);
      case _OnboardingState():
        return onboarding(_that.isLoaded);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserInfoEntity user, bool isLoaded)? authenticated,
    TResult? Function(bool isLoaded)? initial,
    TResult? Function(bool isLoaded)? login,
    TResult? Function(bool isLoaded)? onboarding,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticatedState() when authenticated != null:
        return authenticated(_that.user, _that.isLoaded);
      case _InitialState() when initial != null:
        return initial(_that.isLoaded);
      case _LoginState() when login != null:
        return login(_that.isLoaded);
      case _OnboardingState() when onboarding != null:
        return onboarding(_that.isLoaded);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AuthenticatedState implements AuthState {
  const _AuthenticatedState({required this.user, this.isLoaded = false});

  final UserInfoEntity user;
  @override
  @JsonKey()
  final bool isLoaded;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthenticatedStateCopyWith<_AuthenticatedState> get copyWith =>
      __$AuthenticatedStateCopyWithImpl<_AuthenticatedState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthenticatedState &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, isLoaded);

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user, isLoaded: $isLoaded)';
  }
}

/// @nodoc
abstract mixin class _$AuthenticatedStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthenticatedStateCopyWith(
          _AuthenticatedState value, $Res Function(_AuthenticatedState) _then) =
      __$AuthenticatedStateCopyWithImpl;
  @override
  @useResult
  $Res call({UserInfoEntity user, bool isLoaded});

  $UserInfoEntityCopyWith<$Res> get user;
}

/// @nodoc
class __$AuthenticatedStateCopyWithImpl<$Res>
    implements _$AuthenticatedStateCopyWith<$Res> {
  __$AuthenticatedStateCopyWithImpl(this._self, this._then);

  final _AuthenticatedState _self;
  final $Res Function(_AuthenticatedState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
    Object? isLoaded = null,
  }) {
    return _then(_AuthenticatedState(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserInfoEntity,
      isLoaded: null == isLoaded
          ? _self.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoEntityCopyWith<$Res> get user {
    return $UserInfoEntityCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc

class _InitialState implements AuthState {
  const _InitialState({this.isLoaded = false});

  @override
  @JsonKey()
  final bool isLoaded;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InitialStateCopyWith<_InitialState> get copyWith =>
      __$InitialStateCopyWithImpl<_InitialState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InitialState &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoaded);

  @override
  String toString() {
    return 'AuthState.initial(isLoaded: $isLoaded)';
  }
}

/// @nodoc
abstract mixin class _$InitialStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$InitialStateCopyWith(
          _InitialState value, $Res Function(_InitialState) _then) =
      __$InitialStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoaded});
}

/// @nodoc
class __$InitialStateCopyWithImpl<$Res>
    implements _$InitialStateCopyWith<$Res> {
  __$InitialStateCopyWithImpl(this._self, this._then);

  final _InitialState _self;
  final $Res Function(_InitialState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoaded = null,
  }) {
    return _then(_InitialState(
      isLoaded: null == isLoaded
          ? _self.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _LoginState implements AuthState {
  const _LoginState({this.isLoaded = false});

  @override
  @JsonKey()
  final bool isLoaded;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginStateCopyWith<_LoginState> get copyWith =>
      __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginState &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoaded);

  @override
  String toString() {
    return 'AuthState.login(isLoaded: $isLoaded)';
  }
}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(
          _LoginState value, $Res Function(_LoginState) _then) =
      __$LoginStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoaded});
}

/// @nodoc
class __$LoginStateCopyWithImpl<$Res> implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoaded = null,
  }) {
    return _then(_LoginState(
      isLoaded: null == isLoaded
          ? _self.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _OnboardingState implements AuthState {
  const _OnboardingState({this.isLoaded = false});

  @override
  @JsonKey()
  final bool isLoaded;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OnboardingStateCopyWith<_OnboardingState> get copyWith =>
      __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OnboardingState &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoaded);

  @override
  String toString() {
    return 'AuthState.onboarding(isLoaded: $isLoaded)';
  }
}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(
          _OnboardingState value, $Res Function(_OnboardingState) _then) =
      __$OnboardingStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoaded});
}

/// @nodoc
class __$OnboardingStateCopyWithImpl<$Res>
    implements _$OnboardingStateCopyWith<$Res> {
  __$OnboardingStateCopyWithImpl(this._self, this._then);

  final _OnboardingState _self;
  final $Res Function(_OnboardingState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoaded = null,
  }) {
    return _then(_OnboardingState(
      isLoaded: null == isLoaded
          ? _self.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
