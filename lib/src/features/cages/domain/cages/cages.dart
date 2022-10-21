import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gliders/src/features/cages/domain/gliders/gliders.dart';

part 'cages.freezed.dart';
part 'cages.g.dart';

@freezed
abstract class Cages with _$Cages {
  const factory Cages({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'gliders') List<Map<String,dynamic>>? gliders,
    @JsonKey(name: 'images') String? images,
    @JsonKey(name: 'notes') String? notes,
  }) = _Cages;

  factory Cages.fromJson(Map<String, dynamic> json) => _$CagesFromJson(json);
}
