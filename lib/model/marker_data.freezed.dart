// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marker_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MarkerData _$MarkerDataFromJson(Map<String, dynamic> json) {
  return _MarkerData.fromJson(json);
}

/// @nodoc
mixin _$MarkerData {
  LatLng get position => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this MarkerData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkerDataCopyWith<MarkerData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkerDataCopyWith<$Res> {
  factory $MarkerDataCopyWith(
          MarkerData value, $Res Function(MarkerData) then) =
      _$MarkerDataCopyWithImpl<$Res, MarkerData>;
  @useResult
  $Res call({LatLng position, String title, String description});
}

/// @nodoc
class _$MarkerDataCopyWithImpl<$Res, $Val extends MarkerData>
    implements $MarkerDataCopyWith<$Res> {
  _$MarkerDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as LatLng,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarkerDataImplCopyWith<$Res>
    implements $MarkerDataCopyWith<$Res> {
  factory _$$MarkerDataImplCopyWith(
          _$MarkerDataImpl value, $Res Function(_$MarkerDataImpl) then) =
      __$$MarkerDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLng position, String title, String description});
}

/// @nodoc
class __$$MarkerDataImplCopyWithImpl<$Res>
    extends _$MarkerDataCopyWithImpl<$Res, _$MarkerDataImpl>
    implements _$$MarkerDataImplCopyWith<$Res> {
  __$$MarkerDataImplCopyWithImpl(
      _$MarkerDataImpl _value, $Res Function(_$MarkerDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarkerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_$MarkerDataImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as LatLng,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkerDataImpl implements _MarkerData {
  const _$MarkerDataImpl(
      {required this.position, required this.title, required this.description});

  factory _$MarkerDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkerDataImplFromJson(json);

  @override
  final LatLng position;
  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'MarkerData(position: $position, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkerDataImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, position, title, description);

  /// Create a copy of MarkerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkerDataImplCopyWith<_$MarkerDataImpl> get copyWith =>
      __$$MarkerDataImplCopyWithImpl<_$MarkerDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkerDataImplToJson(
      this,
    );
  }
}

abstract class _MarkerData implements MarkerData {
  const factory _MarkerData(
      {required final LatLng position,
      required final String title,
      required final String description}) = _$MarkerDataImpl;

  factory _MarkerData.fromJson(Map<String, dynamic> json) =
      _$MarkerDataImpl.fromJson;

  @override
  LatLng get position;
  @override
  String get title;
  @override
  String get description;

  /// Create a copy of MarkerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkerDataImplCopyWith<_$MarkerDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
