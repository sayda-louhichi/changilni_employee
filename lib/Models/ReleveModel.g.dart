// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReleveModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleveModel _$ReleveModelFromJson(Map<String, dynamic> json) {
  return ReleveModel(
    coverImage: json['coverImage'] as String,
    id: json['_id'] as String,
    email: json['email'] as String,
    immatriculation: json['immatriculation'] as String,
    adress: json['adress'] as String,
    parc: json['parc'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ReleveModelToJson(ReleveModel instance) =>
    <String, dynamic>{
      'coverImage': instance.coverImage,
      '_id': instance.id,
      'email': instance.email,
      'immatriculation': instance.immatriculation,
      'adress': instance.adress,
      'parc': instance.parc,
      'name': instance.name,
    };
