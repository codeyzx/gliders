// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Cages _$$_CagesFromJson(Map<String, dynamic> json) => _$_Cages(
      id: json['id'] as String?,
      title: json['title'] as String?,
      category: json['category'] as String?,
      gliders:
          (json['gliders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      images: json['images'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$_CagesToJson(_$_Cages instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'gliders': instance.gliders,
      'images': instance.images,
      'notes': instance.notes,
    };
