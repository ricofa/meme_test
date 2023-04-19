import 'package:json_annotation/json_annotation.dart';

part 'meme_model.g.dart';

@JsonSerializable()
class MemeModel {
  @JsonKey(name: 'success')
  bool? success;
  @JsonKey(name: 'data')
  Data? data;

  MemeModel({this.success, this.data});

  factory MemeModel.fromJson(Map<String, dynamic> json) =>
      _$MemeModelFromJson(json);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'memes')
  List<Memes>? memes;

  Data({this.memes});

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
}

@JsonSerializable()
class Memes {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'width')
  int? width;
  @JsonKey(name: 'height')
  int? height;
  @JsonKey(name: 'boxCount')
  int? boxCount;
  @JsonKey(name: 'captions')
  int? captions;

  Memes(
      {this.id,
        this.name,
        this.url,
        this.width,
        this.height,
        this.boxCount,
        this.captions});

  factory Memes.fromJson(Map<String, dynamic> json) =>
      _$MemesFromJson(json);
}