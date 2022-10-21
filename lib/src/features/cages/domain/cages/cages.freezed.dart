// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cages.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cages _$CagesFromJson(Map<String, dynamic> json) {
  return _Cages.fromJson(json);
}

/// @nodoc
mixin _$Cages {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'gliders')
  List<Map<String, dynamic>>? get gliders => throw _privateConstructorUsedError;
  @JsonKey(name: 'images')
  String? get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'notes')
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CagesCopyWith<Cages> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CagesCopyWith<$Res> {
  factory $CagesCopyWith(Cages value, $Res Function(Cages) then) =
      _$CagesCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'category') String? category,
      @JsonKey(name: 'gliders') List<Map<String, dynamic>>? gliders,
      @JsonKey(name: 'images') String? images,
      @JsonKey(name: 'notes') String? notes});
}

/// @nodoc
class _$CagesCopyWithImpl<$Res> implements $CagesCopyWith<$Res> {
  _$CagesCopyWithImpl(this._value, this._then);

  final Cages _value;
  // ignore: unused_field
  final $Res Function(Cages) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? category = freezed,
    Object? gliders = freezed,
    Object? images = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      gliders: gliders == freezed
          ? _value.gliders
          : gliders // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_CagesCopyWith<$Res> implements $CagesCopyWith<$Res> {
  factory _$$_CagesCopyWith(_$_Cages value, $Res Function(_$_Cages) then) =
      __$$_CagesCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'category') String? category,
      @JsonKey(name: 'gliders') List<Map<String, dynamic>>? gliders,
      @JsonKey(name: 'images') String? images,
      @JsonKey(name: 'notes') String? notes});
}

/// @nodoc
class __$$_CagesCopyWithImpl<$Res> extends _$CagesCopyWithImpl<$Res>
    implements _$$_CagesCopyWith<$Res> {
  __$$_CagesCopyWithImpl(_$_Cages _value, $Res Function(_$_Cages) _then)
      : super(_value, (v) => _then(v as _$_Cages));

  @override
  _$_Cages get _value => super._value as _$_Cages;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? category = freezed,
    Object? gliders = freezed,
    Object? images = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$_Cages(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      gliders: gliders == freezed
          ? _value._gliders
          : gliders // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Cages implements _Cages {
  const _$_Cages(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'category') this.category,
      @JsonKey(name: 'gliders') final List<Map<String, dynamic>>? gliders,
      @JsonKey(name: 'images') this.images,
      @JsonKey(name: 'notes') this.notes})
      : _gliders = gliders;

  factory _$_Cages.fromJson(Map<String, dynamic> json) =>
      _$$_CagesFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'category')
  final String? category;
  final List<Map<String, dynamic>>? _gliders;
  @override
  @JsonKey(name: 'gliders')
  List<Map<String, dynamic>>? get gliders {
    final value = _gliders;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'images')
  final String? images;
  @override
  @JsonKey(name: 'notes')
  final String? notes;

  @override
  String toString() {
    return 'Cages(id: $id, title: $title, category: $category, gliders: $gliders, images: $images, notes: $notes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Cages &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other._gliders, _gliders) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            const DeepCollectionEquality().equals(other.notes, notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(_gliders),
      const DeepCollectionEquality().hash(images),
      const DeepCollectionEquality().hash(notes));

  @JsonKey(ignore: true)
  @override
  _$$_CagesCopyWith<_$_Cages> get copyWith =>
      __$$_CagesCopyWithImpl<_$_Cages>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CagesToJson(
      this,
    );
  }
}

abstract class _Cages implements Cages {
  const factory _Cages(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'title') final String? title,
      @JsonKey(name: 'category') final String? category,
      @JsonKey(name: 'gliders') final List<Map<String, dynamic>>? gliders,
      @JsonKey(name: 'images') final String? images,
      @JsonKey(name: 'notes') final String? notes}) = _$_Cages;

  factory _Cages.fromJson(Map<String, dynamic> json) = _$_Cages.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'category')
  String? get category;
  @override
  @JsonKey(name: 'gliders')
  List<Map<String, dynamic>>? get gliders;
  @override
  @JsonKey(name: 'images')
  String? get images;
  @override
  @JsonKey(name: 'notes')
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$_CagesCopyWith<_$_Cages> get copyWith =>
      throw _privateConstructorUsedError;
}
