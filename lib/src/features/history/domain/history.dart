import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.freezed.dart';
part 'history.g.dart';

@freezed
abstract class History with _$History {
  const factory History({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'photo') String? photo,
    @JsonKey(name: 'time') String? time,
    @JsonKey(name: 'cages') String? cages,
    @JsonKey(name: 'cagesId') String? cagesId,
    @JsonKey(name: 'log') String? log,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
}
