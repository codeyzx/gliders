// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

History _$HistoryFromJson(Map<String, dynamic> json) {
  return _History.fromJson(json);
}

/// @nodoc
mixin _$History {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo')
  String? get photo => throw _privateConstructorUsedError;
  @JsonKey(name: 'time')
  String? get time => throw _privateConstructorUsedError;
  @JsonKey(name: 'cages')
  String? get cages => throw _privateConstructorUsedError;
  @JsonKey(name: 'cagesId')
  String? get cagesId => throw _privateConstructorUsedError;
  @JsonKey(name: 'log')
  String? get log => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryCopyWith<History> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryCopyWith<$Res> {
  factory $HistoryCopyWith(History value, $Res Function(History) then) =
      _$HistoryCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'photo') String? photo,
      @JsonKey(name: 'time') String? time,
      @JsonKey(name: 'cages') String? cages,
      @JsonKey(name: 'cagesId') String? cagesId,
      @JsonKey(name: 'log') String? log});
}

/// @nodoc
class _$HistoryCopyWithImpl<$Res> implements $HistoryCopyWith<$Res> {
  _$HistoryCopyWithImpl(this._value, this._then);

  final History _value;
  // ignore: unused_field
  final $Res Function(History) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? time = freezed,
    Object? cages = freezed,
    Object? cagesId = freezed,
    Object? log = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      cages: cages == freezed
          ? _value.cages
          : cages // ignore: cast_nullable_to_non_nullable
              as String?,
      cagesId: cagesId == freezed
          ? _value.cagesId
          : cagesId // ignore: cast_nullable_to_non_nullable
              as String?,
      log: log == freezed
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_HistoryCopyWith<$Res> implements $HistoryCopyWith<$Res> {
  factory _$$_HistoryCopyWith(
          _$_History value, $Res Function(_$_History) then) =
      __$$_HistoryCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'photo') String? photo,
      @JsonKey(name: 'time') String? time,
      @JsonKey(name: 'cages') String? cages,
      @JsonKey(name: 'cagesId') String? cagesId,
      @JsonKey(name: 'log') String? log});
}

/// @nodoc
class __$$_HistoryCopyWithImpl<$Res> extends _$HistoryCopyWithImpl<$Res>
    implements _$$_HistoryCopyWith<$Res> {
  __$$_HistoryCopyWithImpl(_$_History _value, $Res Function(_$_History) _then)
      : super(_value, (v) => _then(v as _$_History));

  @override
  _$_History get _value => super._value as _$_History;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? time = freezed,
    Object? cages = freezed,
    Object? cagesId = freezed,
    Object? log = freezed,
  }) {
    return _then(_$_History(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      cages: cages == freezed
          ? _value.cages
          : cages // ignore: cast_nullable_to_non_nullable
              as String?,
      cagesId: cagesId == freezed
          ? _value.cagesId
          : cagesId // ignore: cast_nullable_to_non_nullable
              as String?,
      log: log == freezed
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_History implements _History {
  const _$_History(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'photo') this.photo,
      @JsonKey(name: 'time') this.time,
      @JsonKey(name: 'cages') this.cages,
      @JsonKey(name: 'cagesId') this.cagesId,
      @JsonKey(name: 'log') this.log});

  factory _$_History.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'photo')
  final String? photo;
  @override
  @JsonKey(name: 'time')
  final String? time;
  @override
  @JsonKey(name: 'cages')
  final String? cages;
  @override
  @JsonKey(name: 'cagesId')
  final String? cagesId;
  @override
  @JsonKey(name: 'log')
  final String? log;

  @override
  String toString() {
    return 'History(id: $id, name: $name, photo: $photo, time: $time, cages: $cages, cagesId: $cagesId, log: $log)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_History &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.photo, photo) &&
            const DeepCollectionEquality().equals(other.time, time) &&
            const DeepCollectionEquality().equals(other.cages, cages) &&
            const DeepCollectionEquality().equals(other.cagesId, cagesId) &&
            const DeepCollectionEquality().equals(other.log, log));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(photo),
      const DeepCollectionEquality().hash(time),
      const DeepCollectionEquality().hash(cages),
      const DeepCollectionEquality().hash(cagesId),
      const DeepCollectionEquality().hash(log));

  @JsonKey(ignore: true)
  @override
  _$$_HistoryCopyWith<_$_History> get copyWith =>
      __$$_HistoryCopyWithImpl<_$_History>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HistoryToJson(
      this,
    );
  }
}

abstract class _History implements History {
  const factory _History(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'photo') final String? photo,
      @JsonKey(name: 'time') final String? time,
      @JsonKey(name: 'cages') final String? cages,
      @JsonKey(name: 'cagesId') final String? cagesId,
      @JsonKey(name: 'log') final String? log}) = _$_History;

  factory _History.fromJson(Map<String, dynamic> json) = _$_History.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'photo')
  String? get photo;
  @override
  @JsonKey(name: 'time')
  String? get time;
  @override
  @JsonKey(name: 'cages')
  String? get cages;
  @override
  @JsonKey(name: 'cagesId')
  String? get cagesId;
  @override
  @JsonKey(name: 'log')
  String? get log;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryCopyWith<_$_History> get copyWith =>
      throw _privateConstructorUsedError;
}
