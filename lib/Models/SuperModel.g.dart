// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModel _$SuperModelFromJson(Map<String, dynamic> json) {
  return SuperModel(
    data: json['data'].map<ReleveModel>((e) =>ReleveModel.fromJson(e)).toList());
  
}

Map<String, dynamic> _$SuperModelToJson(SuperModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
