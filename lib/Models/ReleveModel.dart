import 'package:json_annotation/json_annotation.dart';

part 'ReleveModel.g.dart';

@JsonSerializable()
class ReleveModel {
  String coverImage;
  @JsonKey(name: "_id")
  String id;
  String email;
  String immatriculation;
  String adress;
  String parc;
  String name;

  ReleveModel(
      {this.coverImage,
      this.id,
      this.email,
      this.immatriculation,
      this.adress,
      this.parc,
      this.name});
  factory ReleveModel.fromJson(Map<String, dynamic> json) =>
      _$ReleveModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReleveModelToJson(this);
}