import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'marker_data.freezed.dart';
part 'marker_data.g.dart';

@freezed
abstract class MarkerData with _$MarkerData {
  const factory MarkerData({
    required LatLng position,
    required String title,
    required String description,
  }) = _MarkerData;

  factory MarkerData.fromJson(Map<String, Object?> json) => _$MarkerDataFromJson(json);
}
