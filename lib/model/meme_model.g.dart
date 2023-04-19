// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemeModel _$MemeModelFromJson(Map<String, dynamic> json) => MemeModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemeModelToJson(MemeModel instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      memes: (json['memes'] as List<dynamic>?)
          ?.map((e) => Memes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'memes': instance.memes,
    };

Memes _$MemesFromJson(Map<String, dynamic> json) => Memes(
      id: json['id'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      boxCount: json['boxCount'] as int?,
      captions: json['captions'] as int?,
    );

Map<String, dynamic> _$MemesToJson(Memes instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
      'boxCount': instance.boxCount,
      'captions': instance.captions,
    };
