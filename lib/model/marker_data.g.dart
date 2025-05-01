// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarkerDataImpl _$$MarkerDataImplFromJson(Map<String, dynamic> json) =>
    _$MarkerDataImpl(
      position: LatLng.fromJson(json['position'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$MarkerDataImplToJson(_$MarkerDataImpl instance) =>
    <String, dynamic>{
      'position': instance.position,
      'title': instance.title,
      'description': instance.description,
    };
