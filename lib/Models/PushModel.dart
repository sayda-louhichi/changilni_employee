import 'package:json_annotation/json_annotation.dart';

part 'PushModel.g.dart';

@JsonSerializable()
class PushModel {
 
  String title;
  String body;
  PushModel(
      {this.title,
      this.body,
      });

  factory PushModel.fromJson(Map<String, dynamic> json) =>
      _$PushModelFromJson(json);
  Map<String, dynamic> toJson() => _$PushModelToJson(this);
}