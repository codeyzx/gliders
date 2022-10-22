// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gliders.freezed.dart';
part 'gliders.g.dart';

@freezed
abstract class Gliders with _$Gliders {
  const factory Gliders({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'age') int? age,
  }) = _Gliders;

  factory Gliders.fromJson(Map<String, dynamic> json) => _$GlidersFromJson(json);
}
