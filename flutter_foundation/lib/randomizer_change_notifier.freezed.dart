// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'randomizer_change_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RandomizerStateTearOff {
  const _$RandomizerStateTearOff();

  _RandomizerState call({int min = 0, int max = 0, int? generatedNumber}) {
    return _RandomizerState(
      min: min,
      max: max,
      generatedNumber: generatedNumber,
    );
  }
}

/// @nodoc
const $RandomizerState = _$RandomizerStateTearOff();

/// @nodoc
mixin _$RandomizerState {
  int get min => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;
  int? get generatedNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RandomizerStateCopyWith<RandomizerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RandomizerStateCopyWith<$Res> {
  factory $RandomizerStateCopyWith(
          RandomizerState value, $Res Function(RandomizerState) then) =
      _$RandomizerStateCopyWithImpl<$Res>;
  $Res call({int min, int max, int? generatedNumber});
}

/// @nodoc
class _$RandomizerStateCopyWithImpl<$Res>
    implements $RandomizerStateCopyWith<$Res> {
  _$RandomizerStateCopyWithImpl(this._value, this._then);

  final RandomizerState _value;
  // ignore: unused_field
  final $Res Function(RandomizerState) _then;

  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
    Object? generatedNumber = freezed,
  }) {
    return _then(_value.copyWith(
      min: min == freezed
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int,
      max: max == freezed
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      generatedNumber: generatedNumber == freezed
          ? _value.generatedNumber
          : generatedNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$RandomizerStateCopyWith<$Res>
    implements $RandomizerStateCopyWith<$Res> {
  factory _$RandomizerStateCopyWith(
          _RandomizerState value, $Res Function(_RandomizerState) then) =
      __$RandomizerStateCopyWithImpl<$Res>;
  @override
  $Res call({int min, int max, int? generatedNumber});
}

/// @nodoc
class __$RandomizerStateCopyWithImpl<$Res>
    extends _$RandomizerStateCopyWithImpl<$Res>
    implements _$RandomizerStateCopyWith<$Res> {
  __$RandomizerStateCopyWithImpl(
      _RandomizerState _value, $Res Function(_RandomizerState) _then)
      : super(_value, (v) => _then(v as _RandomizerState));

  @override
  _RandomizerState get _value => super._value as _RandomizerState;

  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
    Object? generatedNumber = freezed,
  }) {
    return _then(_RandomizerState(
      min: min == freezed
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int,
      max: max == freezed
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      generatedNumber: generatedNumber == freezed
          ? _value.generatedNumber
          : generatedNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_RandomizerState extends _RandomizerState with DiagnosticableTreeMixin {
  const _$_RandomizerState({this.min = 0, this.max = 0, this.generatedNumber})
      : super._();

  @JsonKey(defaultValue: 0)
  @override
  final int min;
  @JsonKey(defaultValue: 0)
  @override
  final int max;
  @override
  final int? generatedNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RandomizerState(min: $min, max: $max, generatedNumber: $generatedNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RandomizerState'))
      ..add(DiagnosticsProperty('min', min))
      ..add(DiagnosticsProperty('max', max))
      ..add(DiagnosticsProperty('generatedNumber', generatedNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RandomizerState &&
            (identical(other.min, min) ||
                const DeepCollectionEquality().equals(other.min, min)) &&
            (identical(other.max, max) ||
                const DeepCollectionEquality().equals(other.max, max)) &&
            (identical(other.generatedNumber, generatedNumber) ||
                const DeepCollectionEquality()
                    .equals(other.generatedNumber, generatedNumber)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(min) ^
      const DeepCollectionEquality().hash(max) ^
      const DeepCollectionEquality().hash(generatedNumber);

  @JsonKey(ignore: true)
  @override
  _$RandomizerStateCopyWith<_RandomizerState> get copyWith =>
      __$RandomizerStateCopyWithImpl<_RandomizerState>(this, _$identity);
}

abstract class _RandomizerState extends RandomizerState {
  const factory _RandomizerState({int min, int max, int? generatedNumber}) =
      _$_RandomizerState;
  const _RandomizerState._() : super._();

  @override
  int get min => throw _privateConstructorUsedError;
  @override
  int get max => throw _privateConstructorUsedError;
  @override
  int? get generatedNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RandomizerStateCopyWith<_RandomizerState> get copyWith =>
      throw _privateConstructorUsedError;
}
