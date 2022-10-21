// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'gliders.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Gliders _$GlidersFromJson(Map<String, dynamic> json) {
  return _Gliders.fromJson(json);
}

/// @nodoc
mixin _$Gliders {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender')
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'age')
  int? get age => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GlidersCopyWith<Gliders> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlidersCopyWith<$Res> {
  factory $GlidersCopyWith(Gliders value, $Res Function(Gliders) then) =
      _$GlidersCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'gender') String? gender,
      @JsonKey(name: 'age') int? age});
}

/// @nodoc
class _$GlidersCopyWithImpl<$Res> implements $GlidersCopyWith<$Res> {
  _$GlidersCopyWithImpl(this._value, this._then);

  final Gliders _value;
  // ignore: unused_field
  final $Res Function(Gliders) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? gender = freezed,
    Object? age = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_GlidersCopyWith<$Res> implements $GlidersCopyWith<$Res> {
  factory _$$_GlidersCopyWith(
          _$_Gliders value, $Res Function(_$_Gliders) then) =
      __$$_GlidersCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'gender') String? gender,
      @JsonKey(name: 'age') int? age});
}

/// @nodoc
class __$$_GlidersCopyWithImpl<$Res> extends _$GlidersCopyWithImpl<$Res>
    implements _$$_GlidersCopyWith<$Res> {
  __$$_GlidersCopyWithImpl(_$_Gliders _value, $Res Function(_$_Gliders) _then)
      : super(_value, (v) => _then(v as _$_Gliders));

  @override
  _$_Gliders get _value => super._value as _$_Gliders;

  @override
  $Res call({
    Object? name = freezed,
    Object? gender = freezed,
    Object? age = freezed,
  }) {
    return _then(_$_Gliders(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Gliders implements _Gliders {
  const _$_Gliders(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'gender') this.gender,
      @JsonKey(name: 'age') this.age});

  factory _$_Gliders.fromJson(Map<String, dynamic> json) =>
      _$$_GlidersFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'gender')
  final String? gender;
  @override
  @JsonKey(name: 'age')
  final int? age;

  @override
  String toString() {
    return 'Gliders(name: $name, gender: $gender, age: $age)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Gliders &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.age, age));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(age));

  @JsonKey(ignore: true)
  @override
  _$$_GlidersCopyWith<_$_Gliders> get copyWith =>
      __$$_GlidersCopyWithImpl<_$_Gliders>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GlidersToJson(
      this,
    );
  }
}

abstract class _Gliders implements Gliders {
  const factory _Gliders(
      {@JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'gender') final String? gender,
      @JsonKey(name: 'age') final int? age}) = _$_Gliders;

  factory _Gliders.fromJson(Map<String, dynamic> json) = _$_Gliders.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'gender')
  String? get gender;
  @override
  @JsonKey(name: 'age')
  int? get age;
  @override
  @JsonKey(ignore: true)
  _$$_GlidersCopyWith<_$_Gliders> get copyWith =>
      throw _privateConstructorUsedError;
}
